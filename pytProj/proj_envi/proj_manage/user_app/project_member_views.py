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


#this is the start of project member functions
@login_required
def project_member_dashboard(request):
    if request.user.role == 'project_member':
        return render(request, 'project_member/all_task.html')  
    return redirect('super_admin/login')


@login_required
def all_task(request):
    if request.user.role == 'project_member':
        tasks = Task.objects.filter(assigned_members=request.user).annotate(
            priority_order=models.Case(
                models.When(priority='high', then=models.Value(1)),
                models.When(priority='medium', then=models.Value(2)),
                models.When(priority='low', then=models.Value(3)),
                default=models.Value(4),  
                output_field=models.IntegerField()
            )
        ).order_by('priority_order')  
        
        return render(request, 'project_member/all_task.html', {'tasks': tasks})

    return redirect('super_admin/login')


@login_required
def task_details(request, task_id):
    task = get_object_or_404(Task, id=task_id)
    is_project_member = request.user.role == 'project_member'

    if request.method == 'POST' and is_project_member:
        files = request.FILES.getlist('uploadFile[]')
        for uploaded_file in files:
            File.objects.create(
                task=task,
                uploaded_by=request.user,
                file=uploaded_file
            )
        task.update_progress()
        if task.progress == 100:
            task.status = 'completed'
            task.save()
        return redirect('task_details', task_id=task.id)

    manager_files = File.objects.filter(task=task, uploaded_by__role='project_manager')
    member_files = File.objects.filter(task=task, uploaded_by=request.user)

    return render(request, 'project_member/task_details.html', {
        'task': task,
        'manager_files': manager_files,
        'member_files': member_files,
    })
    

@login_required
def member_gantt_chart(request):
    projects = Project.objects.filter(tasks__assigned_members=request.user).distinct()
    return render(request, 'project_member/member_chart.html', {'projects': projects})


@login_required
def get_member_gantt_data(request):
    project_id = request.GET.get('project_id')
    if not project_id:
        return JsonResponse({'error': 'Project ID is required'}, status=400)

    project = get_object_or_404(Project, id=project_id)

    tasks = project.tasks.filter(assigned_members=request.user)
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
    })

def get_notifications(request):
    user = request.user
    notifications = Notification.objects.filter(user=user)

    notification_list = []
    for notification in notifications:
        task_id = Task.objects.filter(name__in=[notification.message.split("'")[1]]).values_list('id', flat=True).first()

        notification_list.append({
            'id': notification.id,
            'message': notification.message,
            'created_at': notification.created_at,
            'is_read': notification.is_read,
            'task_id': task_id,  
        })

    return JsonResponse({'notifications': notification_list})

@login_required
def mark_all_notifications_as_read(request):
    notifications = Notification.objects.filter(user=request.user, is_read=False)
    notifications.update(is_read=True) 
    return JsonResponse({"success": True})


@login_required
def member_files(request):
    projects = Project.objects.filter(tasks__assigned_members=request.user).distinct()

    selected_project = None
    files = []

    if request.method == 'POST':
        selected_project_id = request.POST.get('project')
        if selected_project_id:
            selected_project = Project.objects.get(id=selected_project_id)

        if 'upload_file' in request.POST and selected_project:
            uploaded_file = request.FILES.get('file')
            if uploaded_file:
                file_record = File.objects.create(
                    task=None,
                    uploaded_by=request.user,
                    file=uploaded_file
                )

                for member in selected_project.tasks.values_list('assigned_members', flat=True).distinct():
                    try:
                        user = User.objects.get(id=member)
                        FileAssignment.objects.create(
                            file=file_record,
                            member=user,
                            project=selected_project
                        )
                    except User.DoesNotExist:
                        continue

                messages.success(request, "File uploaded and shared with project members.")

    if selected_project:
        files = File.objects.filter(
            fileassignment__project=selected_project,
            fileassignment__member=request.user
        ).distinct()

    return render(request, 'project_member/member_file.html', {
        'projects': projects,
        'files': files,
        'selected_project': selected_project
    })

#this is the end of project member functions