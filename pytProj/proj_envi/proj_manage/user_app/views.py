from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from datetime import datetime
from .models import *
from .project_manager_views import *
from .project_member_views import *
from django.shortcuts import get_object_or_404
from django.contrib.auth.hashers import make_password
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.password_validation import validate_password, ValidationError


def logout_view(request):
    logout(request)
    return redirect('login')

# role based login
def login_view(request):
    if request.method == 'POST':
        login_input = request.POST['username']  
        password = request.POST['password']
 
        try: 
            user_obj = User.objects.get(email=login_input)
            username = user_obj.username
        except User.DoesNotExist:
           
            username = login_input

        
        user = authenticate(request, username=username, password=password)

        if user is not None:
            if user.role == 'super_admin':
                login(request, user)
                return redirect('dashboard')  
            elif user.role == 'project_manager':
                login(request, user)
                return redirect('project_manager_project')  
            elif user.role == 'project_member':  
                login(request, user)
                return redirect('all_task') 
            else:
                return render(request, 'super_admin/login.html', {'error': 'You do not have access to the system.'})
        else:
            return render(request, 'super_admin/login.html', {'error': 'Invalid credentials or insufficient privileges'})

    return render(request, 'super_admin/login.html')    
# role based login


#this is start the profile CRUD functions
@login_required
def edit_profile(request):
    if request.method == 'POST':
        user = request.user
        user.username = request.POST.get('username')
        user.first_name = request.POST.get('first_name')
        user.last_name = request.POST.get('last_name')
        user.save()
        messages.success(request, 'Profile updated successfully!')

        if user.role == 'project_manager':
            return redirect('project_manager_project')
        elif user.role == 'project_member':
            return redirect('all_task')
        else:
            return redirect('default_dashboard')  

@login_required
def change_password(request):
    if request.method == "POST":
        user = request.user
        old_password = request.POST['old_password']
        new_password = request.POST['new_password']
        confirm_new_password = request.POST['confirm_new_password']

        if user.check_password(old_password):
            if new_password == confirm_new_password:
                user.set_password(new_password)
                user.save()

                # Update session to prevent logout after password change
                update_session_auth_hash(request, user)

                messages.success(request, "Password changed successfully!")
                if user.role == 'project_manager':
                    return redirect('project_manager_project')
                elif user.role == 'project_member':
                    return redirect('all_task')
                else:
                    return redirect('default_dashboard')
            else:
                messages.error(request, "New passwords do not match.")
        else:
            messages.error(request, "Old password is incorrect.")

    # Redirect back to the appropriate dashboard to display errors or success messages
    if request.user.role == 'project_manager':
        return redirect('project_manager_project')
    elif request.user.role == 'project_member':
        return redirect('all_task')
    else:
        return redirect('default_dashboard')


@login_required
def delete_account(request):
    if request.method == 'POST':
        request.user.delete()
        messages.success(request, 'Your account has been deleted.')
        return redirect('login')
#this is end the profile CRUD functions


# this is the super admin functions
@login_required
def dashboard(request):
    if request.user.role == 'super_admin':
       project_managers = User.objects.filter(role='project_manager')
       return render(request, 'super_admin/dashboard.html', {'project_managers': project_managers})
    return redirect('login')

@login_required
def create_project_manager(request):
    if request.user.role != 'super_admin':
        return redirect('dashboard')

    if request.method == 'POST':
        username = request.POST['username']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        email = request.POST['email']
        password = request.POST['password']
        confirm_password = request.POST['confirm_password']

        if User.objects.filter(email=email).exists():
            messages.error(request, 'A user with this email already exists.')
            return redirect('dashboard')

        if User.objects.filter(username=username).exists():
            messages.error(request, 'A user with this username already exists.')
            return redirect('dashboard')

        if password != confirm_password:
            messages.error(request, 'Passwords do not match.')
            return redirect('dashboard')
            
        user = User.objects.create_user(
            username=username,
            first_name=first_name,
            last_name=last_name,
            email=email,
            password=password,
            role='project_manager'
        )
        
        messages.success(request, 'Project Manager created successfully!')
        return redirect('dashboard')

    return render(request, 'super_admin/dashboard.html')

    
# Edit Project Manager
@login_required
def edit_project_manager(request, manager_id):
    if request.user.role != 'super_admin':
        return redirect('dashboard')

    manager = get_object_or_404(User, id=manager_id)

    if request.method == 'POST':
        manager.username = request.POST['username']
        manager.first_name = request.POST['first_name']
        manager.last_name = request.POST['last_name']
        manager.email = request.POST['email']
        manager.save()
        messages.success(request, 'Project Manager updated successfully!')
        return redirect('dashboard')

    return render(request, 'edit_project_manager_modal.html', {'manager': manager})


# Delete Project Manager
@login_required
def delete_project_manager(request, manager_id):
    if request.user.role != 'super_admin':
        return redirect('dashboard')

    manager = get_object_or_404(User, id=manager_id)
    manager.delete()
    messages.success(request, 'Project Manager deleted successfully!')
    return redirect('dashboard')


# Change Project Manager Password
@login_required
def change_project_manager_password(request, manager_id):
    if request.user.role != 'super_admin':
        return redirect('dashboard')

    manager = get_object_or_404(User, id=manager_id)

    if request.method == 'POST':
        old_password = request.POST['old_password']
        new_password = request.POST['new_password']
        confirm_new_password = request.POST['confirm_new_password']

        if manager.check_password(old_password):
            if new_password == confirm_new_password:
                manager.set_password(new_password)
                manager.save()
                update_session_auth_hash(request, manager)
                messages.success(request, 'Password changed successfully!')
                return redirect('dashboard')
            else:
                messages.error(request, "New passwords do not match.")
        else:
            messages.error(request, "Old password is incorrect.")

    return render(request, 'change_password_modal.html', {'manager': manager})

# this is the end of super admin functions



