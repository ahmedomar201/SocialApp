abstract class SocialStates {}

class SocialInitialState extends SocialStates {}


class GetUserLoadingState extends SocialStates {}
class GetUserSuccessState extends SocialStates {}
class GetUserErrorState extends SocialStates {
  final String error;

  GetUserErrorState(this.error);
}


class ChangeBottomNavState extends SocialStates {}


class NewPostState extends SocialStates {}



class ProfileImagePickedSuccessState extends SocialStates {}
class ProfileImagePickedErrorState extends SocialStates {}



class CoverImagePickedSuccessState extends SocialStates {}
class CoverImagePickedErrorState extends SocialStates {}



class UploadProfileImageSuccessState extends SocialStates {}
class UploadProfileImageErrorState extends SocialStates {}



class UploadCoverImageSuccessState extends SocialStates {}
class UploadCoverImageErrorState extends SocialStates {}



class UserUpdateErrorState extends SocialStates {}
class UserUpdateLoadingState extends SocialStates {}



class CreatePostErrorState extends SocialStates {}
class  CreatePostLoadingState extends SocialStates {}
class CreatePostSuccessState extends SocialStates {}


class PostImagePickedSuccessState extends SocialStates {}
class PostImagePickedErrorState extends SocialStates {}

class RemovePostImageState extends SocialStates {}


class GetPostsLoadingState extends SocialStates {}
class GetPostsSuccessState extends SocialStates {}
class GetPostsErrorState extends SocialStates
{
  final String error;
  GetPostsErrorState(this.error);
}



class LikePostLoadingState extends SocialStates {}
class LikePostSuccessState extends SocialStates {}
class LikePostErrorState extends SocialStates {
  final String error;

  LikePostErrorState(this.error);
}