from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from datetime import datetime
from .models import *
from django.shortcuts import get_object_or_404
from django.contrib.auth.hashers import make_password
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.password_validation import validate_password, ValidationError
from django.core.files.storage import FileSystemStorage
from django.core.files.storage import default_storage
from django.utils import timezone
from django.http import QueryDict
from django.http import JsonResponse
from .models import Notification

# this is the start of project manager functions
@login_required

def project_manager_project(request):
    if request.user.role == 'project_manager':
        projects = Project.objects.filter(created_by=request.user)
        for project in projects:
            project.update_progress()  # Ensure progress is up to date
        project_members = User.objects.filter(role='project_member')
        return render(request, 'project_manager/project_manager_project.html', {
            'projects': projects,
            'project_members': project_members
        })
    return redirect('login')
  



def create_project(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        description = request.POST.get('description')
        start_date_raw = request.POST.get('start_date')
        end_date_raw = request.POST.get('end_date')

        try:
            start_date = datetime.fromisoformat(start_date_raw)
            end_date = datetime.fromisoformat(end_date_raw)

            if start_date >= end_date:
                messages.error(request, "Start date must be before end date.")
                return redirect('project_manager')

            Project.objects.create(
                name=name,
                description=description,
                start_date=start_date,
                end_date=end_date,
                created_by=request.user
            )
            messages.success(request, "Project created successfully!")
        except ValueError:
            messages.error(request, "Invalid date format.")
        return redirect('project_manager_project')  


@login_required
def create_project_member(request):
    if request.user.role != 'project_manager':
        return redirect('project_manager_project')

    project_members = User.objects.filter(created_by=request.user, role='project_member')

    if request.method == 'POST':
        username = request.POST.get('username')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        email = request.POST.get('email')
        password = request.POST.get('password')
        confirm_password = request.POST.get('confirm_password')

        if User.objects.filter(email=email).exists():
            messages.error(request, 'A user with this email already exists.')
            return redirect('create_project_member')

        if User.objects.filter(username=username).exists():
            messages.error(request, 'A user with this username already exists.')
            return redirect('create_project_member')

        if password != confirm_password:
            messages.error(request, 'Passwords do not match.')
            return redirect('create_project_member')

        user = User.objects.create_user(
            username=username,
            first_name=first_name,
            last_name=last_name,
            email=email,
            password=password,
            role='project_member'
        )

        user.created_by = request.user
        user.save()

        messages.success(request, 'Project Member created successfully!')
        return redirect('create_project_member')

    return render(request, 'project_manager/create_member.html', {'project_members': project_members})


@login_required
def delete_project_member(request, member_id):
    if request.user.role != 'project_manager':
        return redirect('project_manager_project')

    member = get_object_or_404(User, id=member_id, created_by=request.user, role='project_member')
    
    member.delete()

    messages.success(request, 'Project Member deleted successfully!')
    return redirect('create_project_member')
   

@login_required
def view_project_details(request, project_id):
    if request.user.role == 'project_manager':
        project = get_object_or_404(Project, id=project_id, created_by=request.user)

        task_id = request.GET.get('task_id')
        if task_id:
            try:
                task_id = int(task_id) 
                tasks = project.tasks.filter(id=task_id)
                if not tasks.exists():
                    tasks = [] 
            except ValueError:
                tasks = [] 
        else:
            tasks = project.tasks.all().annotate(
                priority_order=models.Case(
                    models.When(priority='high', then=models.Value(1)),
                    models.When(priority='medium', then=models.Value(2)),
                    models.When(priority='low', then=models.Value(3)),
                    default=models.Value(4),
                    output_field=models.IntegerField()
                )
            ).order_by('priority_order')

        project_members = User.objects.filter(role='project_member')

        return render(request, 'project_manager/project_details.html', {
            'project': project,
            'tasks': tasks,
            'project_members': project_members
        })

    return redirect('project_manager_project')





from django.core.files.storage import FileSystemStorage

@login_required
def create_task(request, project_id):
    if request.method == 'POST' and request.user.role == 'project_manager':
        project = get_object_or_404(Project, id=project_id, created_by=request.user)
        name = request.POST.get('name')
        description = request.POST.get('description')
        start_date_raw = request.POST.get('start_date')
        end_date_raw = request.POST.get('end_date')
        priority = request.POST.get('priority')
        files = request.FILES.getlist('files')  

        try:
            start_date = timezone.make_aware(datetime.fromisoformat(start_date_raw))
            end_date = timezone.make_aware(datetime.fromisoformat(end_date_raw))

            if start_date >= end_date:
                messages.error(request, "Start date must be before end date.")
                return redirect('view_project_details', project_id=project_id)

            task = Task.objects.create(
                project=project,
                name=name,
                description=description,
                start_date=start_date,
                end_date=end_date,
                priority=priority
            )

            for file in files:
                File.objects.create(
                    task=task,
                    uploaded_by=request.user,
                    file=file
                )

            messages.success(request, "Task created successfully!")
        except ValueError:
            messages.error(request, "Invalid date format.")
        return redirect('view_project_details', project_id=project_id)

    return redirect('view_project_details', project_id=project_id)


@login_required
def edit_task(request, task_id):
    task = get_object_or_404(Task, id=task_id)
    
    if request.method == 'POST' and request.user.role == 'project_manager':
        name = request.POST.get('name')
        description = request.POST.get('description')
        start_date_raw = request.POST.get('start_date')
        end_date_raw = request.POST.get('end_date')
        priority = request.POST.get('priority')
        delete_files = request.POST.getlist('delete_files')
        new_files = request.FILES.getlist('new_files')

        try:
            start_date = timezone.make_aware(datetime.fromisoformat(start_date_raw))
            end_date = timezone.make_aware(datetime.fromisoformat(end_date_raw))

            if start_date >= end_date:
                messages.error(request, "Start date must be before end date.")
                return redirect('edit_task', task_id=task.id)

            task.name = name
            task.description = description
            task.start_date = start_date
            task.end_date = end_date
            task.priority = priority
            task.save()

            for file_id in delete_files:
                file_instance = File.objects.get(id=file_id, task=task)
                file_instance.file.delete(save=False) 
                file_instance.delete()

            for file in new_files:
                File.objects.create(task=task, uploaded_by=request.user, file=file)

            messages.success(request, "Task updated successfully!")
        except ValueError:
            messages.error(request, "Invalid date format.")
        return redirect('view_project_details', project_id=task.project.id)

    return render(request, 'project_manager/edit_task.html', {'task': task})


@login_required
def assign_task_member(request, task_id):
    if request.method == 'POST' and request.user.role == 'project_manager':
        task = get_object_or_404(Task, id=task_id, project__created_by=request.user)
        member_ids = request.POST.getlist('member_ids')
        task.assigned_members.clear()

        for member_id in member_ids:
            member = get_object_or_404(User, id=member_id, role='project_member')
            task.assigned_members.add(member)

            
            Notification.objects.create(
                user=member,
                message=f"You have been assigned to the task '{task.name}' in project '{task.project.name}'."
            )

        messages.success(request, "Members assigned to the task successfully!")
        return redirect('view_project_details', project_id=task.project.id)

    return redirect('project_manager_project')


def edit_project(request, project_id):
    project = get_object_or_404(Project, id=project_id)

    if request.method == 'POST':
        name = request.POST.get('name')
        description = request.POST.get('description')
        start_date_raw = request.POST.get('start_date')
        end_date_raw = request.POST.get('end_date')

        try:
            start_date = datetime.fromisoformat(start_date_raw)
            end_date = datetime.fromisoformat(end_date_raw)

            if start_date >= end_date:
                messages.error(request, "Start date must be before end date.")
                return redirect('edit_project', project_id=project.id)

            project.name = name
            project.description = description
            project.start_date = start_date
            project.end_date = end_date
            project.save()

            messages.success(request, "Project updated successfully!")
            return redirect('view_project_details', project_id=project.id)
        except ValueError:
            messages.error(request, "Invalid date format.")
    return render(request, 'project_manager/edit_project.html', {'project': project})

def delete_project(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    project.delete()
    messages.success(request, "Project deleted successfully!")
    return redirect('project_manager_project')



@login_required
def delete_task(request, task_id):
    task = get_object_or_404(Task, id=task_id)
    
    if request.user.role == 'project_manager':
        task.delete()
        messages.success(request, "Task deleted successfully.")
    else:
        messages.error(request, "You don't have permission to delete this task.")
    
    return redirect('view_project_details', project_id=task.project.id)


@login_required
def members_work(request, task_id):
    task = get_object_or_404(Task, id=task_id)
    is_project_manager = request.user.role == 'project_manager'

    if not is_project_manager:
        files = File.objects.filter(task=task, uploaded_by=request.user)
    else:
        files = File.objects.filter(task=task).exclude(uploaded_by__role='project_manager')

    return render(request, 'project_manager/member_work.html', {'task': task, 'files': files})


@login_required
def gantt_chart(request):
    if request.user.role == 'project_manager':
        projects = Project.objects.filter(created_by=request.user)
    else:
        projects = Project.objects.none() 

    return render(request, 'project_manager/gantt_chart.html', {'projects': projects})

@login_required
def get_gantt_data(request):
    project_id = request.GET.get('project_id')
    if not project_id:
        return JsonResponse({'error': 'Project ID is required'}, status=400)

    project = get_object_or_404(Project, id=project_id, created_by=request.user)

    tasks = project.tasks.all()
    task_data = []
    for task in tasks:
        task_data.append({
            'id': task.id,
            'name': task.name,
            'start_date': task.start_date.strftime('%Y-%m-%d'),
            'end_date': task.end_date.strftime('%Y-%m-%d'),
            'progress': task.progress,
        })

    return JsonResponse({
        'tasks': task_data,
        'project_start_date': project.start_date.strftime('%Y-%m-%d'),
        'project_end_date': project.end_date.strftime('%Y-%m-%d'),
        'project_progress': project.progress_percentage  # Add project progress data
    })



@login_required
def file_sharing(request):
    projects = Project.objects.filter(created_by=request.user)  
    selected_project = None
    files = []
    project_members = [] 

    if request.method == 'POST':
        project_id = request.POST.get('project')
        members = request.POST.getlist('members')
        uploaded_file = request.FILES.get('file')

        if project_id and uploaded_file:
            selected_project = Project.objects.get(id=project_id)
            # Explicitly set task to None
            task = None  # Ensure task is null (None)

            # Create the file record with task set to None
            file_record = File.objects.create(
                task=task,  # This will be null
                uploaded_by=request.user,
                file=uploaded_file
            )

            if members:
                for member_id in members:
                    member = User.objects.get(id=member_id)
                    FileAssignment.objects.create(
                        file=file_record,
                        member=member,
                        project=selected_project
                    )

            messages.success(request, "File successfully uploaded and shared.")
            return redirect('file_sharing')

        if project_id:  
            selected_project = Project.objects.get(id=project_id)
            files = File.objects.filter(fileassignment__project=selected_project).distinct()

            project_members = User.objects.filter(assigned_tasks__project=selected_project).distinct()

    return render(request, 'project_manager/manager_file.html', {
        'projects': projects,
        'selected_project': selected_project,
        'files': files,
        'project_members': project_members  
    })




def get_project_members(request):
    project_id = request.GET.get('project_id')
    project = Project.objects.get(id=project_id)

    members = project.tasks.values('assigned_members__id', 'assigned_members__username').distinct()

    members_list = [{"id": member['assigned_members__id'], "username": member['assigned_members__username']} for member in members]
    
    return JsonResponse({'members': members_list})


# this is the end of project manager functions 