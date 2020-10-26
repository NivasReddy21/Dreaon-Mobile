import 'package:buddy/views/tabs/profile/profile_builder.dart';

import '../views/live_tv/live_tv.page.dart';
import '../views/live_tv_preview/live_tv_preview.page.dart';

import '../views/settings_base_view/settings_base_view.page.dart';

import '../views/friends/friends.page.dart';
import '../views/post_details/post_details.page.dart';
import '../views/call/call.page.dart';
import '../views/followers/followers.page.dart';
import '../views/create_post/create_post.page.dart';
import '../views/settings/settings.page.dart';
import '../views/viewers/image_viewer/image_viewer.page.dart';
import '../views/viewers/video_viewer/video_viewer.page.dart';
import '../views/comments/comments.page.dart';
import '../views/search/search.page.dart';
import '../views/story_view/story_view.page.dart';
import '../views/invite_friends/invite_friends.page.dart';
import '../views/notification_toggle/notification_toggle.page.dart';
import '../views/auth/forgot_password/forgot_password.page.dart';
import '../views/message_details.dart/message_details.page.dart';
import '../views/tabs/tabs.page.dart';
import '../views/auth/landing/landing.page.dart';
import '../views/auth/login/login.page.dart';
import '../views/auth/register/register.page.dart';
import '../views/onboarding/onboarding.page.dart';
import 'package:flutter/material.dart';
import '../views/splash/splash.page.dart';
import '../constants/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => SplashPage());
      break;
    case AppRoutes.onboarding:
      return MaterialPageRoute(builder: (_) => OnboardingPage());
      break;
    case AppRoutes.landing:
      return MaterialPageRoute(builder: (_) => LandingPage());
      break;
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => LoginPage());
      break;
    case AppRoutes.register:
      return MaterialPageRoute(builder: (_) => RegisterPage());
      break;
    case AppRoutes.forgotPassword:
      return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      break;
    case AppRoutes.inviteFriends:
      return MaterialPageRoute(builder: (_) => InviteFriendsPage());
      break;
    case AppRoutes.notificationToggle:
      return MaterialPageRoute(builder: (_) => NotificationTogglePage());
      break;
    case AppRoutes.tabs:
      return MaterialPageRoute(builder: (_) => TabsPage());
      break;
    case AppRoutes.search:
      return MaterialPageRoute(builder: (_) => SearchPage());
      break;
    case AppRoutes.comments:
      return MaterialPageRoute(
          builder: (_) => CommentsPage(
                postId: settings.arguments,
              ));
      break;
    case AppRoutes.messageDetails:
      return MaterialPageRoute(
        builder: (_) => MessageDetailsPage(
          user: settings.arguments,
        ),
      );
      break;
    case AppRoutes.storyView:
      return MaterialPageRoute(
        builder: (_) => StoryViewPage(
          user: settings.arguments,
        ),
      );
      break;

    case AppRoutes.imageViewer:
      return MaterialPageRoute(
        builder: (_) => ImageViewerPage(
          url: settings.arguments,
        ),
      );
      break;

    case AppRoutes.videoViewer:
      return MaterialPageRoute(
        builder: (_) => VideoViewerPage(
          url: settings.arguments,
        ),
      );
      break;

    case AppRoutes.profile:
      return MaterialPageRoute(
        builder: (_) => ProfileBuilder(
          userId: settings.arguments,
        ),
      );
      break;

    case AppRoutes.settings:
      return MaterialPageRoute(builder: (_) => SettingsPage());
      break;

    case AppRoutes.friends:
      return MaterialPageRoute(builder: (_) => FriendsPage());
      break;

    case AppRoutes.createPost:
      return MaterialPageRoute(builder: (_) => CreatePostPage());
      break;

    case AppRoutes.settingsBase:
      return MaterialPageRoute(
        builder: (_) => SettingsBaseViewPage(
          baseView: settings.arguments,
        ),
      );
      break;

    case AppRoutes.followers:
      return MaterialPageRoute(
        builder: (_) => FollowersPage(
          user: settings.arguments,
        ),
      );
      break;

    case AppRoutes.call:
      return MaterialPageRoute(
        builder: (_) => CallPage(
          call: settings.arguments,
        ),
      );
      break;

    case AppRoutes.postDetails:
      return MaterialPageRoute(
        builder: (_) => PostDetailsPage(
          post: settings.arguments,
        ),
      );
      break;

    case AppRoutes.liveTv:
      return MaterialPageRoute(
        builder: (_) => LiveTvPage(),
      );
      break;

    case AppRoutes.liveTvPreview:
      return MaterialPageRoute(
        builder: (_) => LiveTvPreviewPage(
          liveTv: settings.arguments,
        ),
      );
      break;

    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
