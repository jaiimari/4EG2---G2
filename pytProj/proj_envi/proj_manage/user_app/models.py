from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.timezone import now

# Extend the default User model
class User(AbstractUser):
    ROLE_CHOICES = [
        ('super_admin', 'Super Admin'),
        ('project_manager', 'Project Manager'),
        ('project_member', 'Project Member'),
    ]
    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default='project_member')
    created_by = models.ForeignKey(
        'self',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='created_users'
    )

    def __str__(self):
        return self.username


# Model for Projects
class Project(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    progress_percentage = models.FloatField(default=0)  
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name="created_projects")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

    def update_progress(self):
        tasks = self.tasks.all()
        total_task_progress = 0
        total_tasks = tasks.count()

        if total_tasks > 0:
            for task in tasks:
                total_task_progress += task.progress  # Add up progress from each task
            self.progress_percentage = total_task_progress / total_tasks  # Calculate average progress
        else:
            self.progress_percentage = 0
        
        self.save()


# Model for Tasks
class Task(models.Model):
    PRIORITY_CHOICES = [
        ('low', 'Low'),
        ('medium', 'Medium'),
        ('high', 'High'),
    ]

    STATUS_CHOICES = [
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
    ]

    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name="tasks")
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    status = models.CharField(max_length=15, choices=STATUS_CHOICES, default='in_progress')
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES, default='medium')
    assigned_members = models.ManyToManyField(User, related_name="assigned_tasks", blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    progress = models.PositiveIntegerField(default=0)

    def __str__(self):
        return f"{self.name} - {self.project.name}"

    def is_overdue(self):
        return self.end_date < now() and self.status != 'completed'
    
    def update_progress(self):
        total_members = self.assigned_members.count()
        if total_members == 0:
            self.progress = 0
        else:
            uploaded_members = File.objects.filter(task=self, uploaded_by__in=self.assigned_members.all()).values('uploaded_by').distinct().count()
            self.progress = (uploaded_members / total_members) * 100
        self.save()

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        self.project.update_progress()


class File(models.Model):
    task = models.ForeignKey(
        Task, 
        null=True,  
        blank=True,  
        on_delete=models.CASCADE,  
        related_name="files"
    )
    uploaded_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name="uploaded_files")
    file = models.FileField(upload_to='task_files/')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"File: {self.file.name} for Task: {self.task.name if self.task else 'No Task'}"

        

class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="notifications")
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Notification for {self.user.username}: {self.message[:50]}"


class FileAssignment(models.Model):
    file = models.ForeignKey(File, on_delete=models.CASCADE)
    member = models.ForeignKey(User, on_delete=models.CASCADE)  
    project = models.ForeignKey(Project, on_delete=models.CASCADE) 
    assigned_at = models.DateTimeField(auto_now_add=True)  

    def __str__(self):
        return f"File: {self.file.file.name} assigned to {self.member.username} in Project: {self.project.name}"


