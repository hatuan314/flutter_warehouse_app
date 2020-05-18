/// A value mapping the View UI to the state in the Model.
///
/// This will contain all the possible states for any view, custom enums can be created for separate views if required
enum ViewState {
  Busy, // Typically shows a loading indicator of some sorts
  DataFetched, // Indicates that there's data available on the view
  NoDataAvailable, // Indicates that data was fetched successfully but nothing is available
  Error, // Indicates there's an error on the view
  Success, // Successful action occurred
  WaitingForInput, // The starting state that a form view is in
  NotReady // Toast
}
enum CheckoutState {
  NotLogin, // Typically shows a loading indicator of some sorts
  LoginNoAddress, // Indicates that there's data available on the view
  LoginHaveAddress, // Indicates that data was fetched successfully but nothing is available
}

enum ProductType { Simple, Configurable, Downloadable, Grouped, Bundle }
enum ProductCartType {
  ProductDetail,
  CartView,
}

enum AddNewAddressState {
  AddNewAddress,
  EditAddress,
  EditAddressFromDashboard,
  AddNewCheckoutFromCart,
  AddNewCheckoutFromCheckout,
  EditCheckout
}

enum SocialLoginType { Google, Facebook }
