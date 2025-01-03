from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('', views.login_view, name='login'),
    path('login/', views.login_view, name='login'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('logout/', views.logout_view, name='logout'),
    path('edit-profile/', views.edit_profile, name='edit_profile'),
    path('change-password/', views.change_password, name='change_password'),
    path('delete-account/', views.delete_account, name='delete_account'),

    #start of super admin path
    path('create-project-manager/', views.create_project_manager, name='create_project_manager'),  
    path('edit-project-manager/<int:manager_id>/', views.edit_project_manager, name='edit_project_manager'),
    path('delete-project-manager/<int:manager_id>/', views.delete_project_manager, name='delete_project_manager'),
    path('change-project-manager-password/<int:manager_id>/', views.change_project_manager_password, name='change_project_manager_password'),
    #end of super admin path

    #start of project manager path
    path("create_project/", views.create_project, name="create_project"),
    path('project/<int:project_id>/', views.view_project_details, name='view_project_details'),
    path('project/<int:project_id>/create-task/', views.create_task, name='create_task'),
    path('task/<int:task_id>/assign-member/', views.assign_task_member, name='assign_task_member'),
    path('project-manager-project/', views.project_manager_project, name='project_manager_project'),
    path('create-project-member/', views.create_project_member, name='create_project_member'),
    path('delete-member/<int:member_id>/', views.delete_project_member, name='delete_project_member'),
    path('project/<int:project_id>/edit/', views.edit_project, name='edit_project'),
    path('project/<int:project_id>/delete/', views.delete_project, name='delete_project'),
    path('task/delete/<int:task_id>/', views.delete_task, name='delete_task'),
    path('task/delete/<int:task_id>/', views.delete_task, name='delete_task'),
    path('task/edit/<int:task_id>/', views.edit_task, name='edit_task'),
    path('task/delete/<int:task_id>/', views.delete_task, name='delete_task'),
    path('gantt-chart/', views.gantt_chart, name='gantt_chart'),
    path('api/get_gantt_data/', views.get_gantt_data, name='get_gantt_data'),
    path('file-sharing/', views.file_sharing, name='file_sharing'),
    path('get-project-members/', views.get_project_members, name='get_project_members'),

    #end of project manager path


    #start of project member path
    path('all-task/', views.all_task, name='all_task'),
    path('task/<int:task_id>/', views.task_details, name='task_details'),
    path('task/<int:task_id>/members_work/', views.members_work, name='members_work'),
    path('member/gantt-chart/', views.member_gantt_chart, name='member_gantt_chart'),
    path('api/get_member_gantt_data/', views.get_member_gantt_data, name='get_member_gantt_data'),
    path('get-notifications/', views.get_notifications, name='get_notifications'),
    path('mark-all-notifications-as-read/', views.mark_all_notifications_as_read, name='mark_all_notifications_as_read'),
    path('member-files/', views.member_files, name='member_files'),
    #end of project member path
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)