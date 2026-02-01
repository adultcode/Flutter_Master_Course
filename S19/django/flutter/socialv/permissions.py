from rest_framework import permissions


class UpdateOwnProfile(permissions.BasePermission):
    """Allow users to edit their own profile"""

    def has_object_permission(self, request, view, obj):
        """Check user is trying to edit their own profile"""
        print(request.user.id)
        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.id == request.user.id


class UpdateOwnStatus(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):

        if __name__ == '__main__':
            if request.method in permissions.SAFE_METHODS:
                return True

            return obj.profile.id == request.user.id

