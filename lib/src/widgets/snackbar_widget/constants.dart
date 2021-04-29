
/// Indicates the animation status
/// [TopSnackBarStatus.showing] TopStatusBar has stopped and the user
/// can see it
/// [TopSnackBarStatus.dismissed] TopStatusBar has finished
/// its mission and returned any pending values
/// [TopSnackBarStatus.isHiding] TopStatusBar is moving
/// towards [TopSnackBarStatus.dismissed]
/// /// [TopSnackBarStatus.isAppearing] Snackbar is moving towards [TopSnackBarStatus.showing]
enum TopSnackBarStatus { showing, dismissed, isHiding, isAppearing }

/// Indicates if snack bar is going to start at the [top]
enum TopSnackBarPosition { top }