import 'package:flutter/material.dart';

int languageStatus = 0;
const String appName = "TE";

//////////////------------------PT----------------------//////////////////////
String get menuProfilerCustomerListTitle => languageStatus == 0 ? "USUÁRIAS" : "USERS";
String get menuProfilerCustomerAboutUsTitle => languageStatus == 0 ? "Sobre nós" : "About Us";
String get menuProfilerCustomerFrequentQuestionsTitle => languageStatus == 0 ? "Perguntas frequentes" : "FAQ";
String get menuProfileTitle => languageStatus == 0 ? "Meu perfil" : "My Profile";
String get menuSubscriptionTitle => languageStatus == 0 ? "Assinaturas" : "Subscriptions";
String get menuSettingsTitle => languageStatus == 0 ? "Configurações" : "Settings";
String get menuLanguageTitle => languageStatus == 0 ? "linguagem" : "Language";
String get menuCPanelTitle => languageStatus == 0 ? "ADMINISTRAÇÃO" : "ADMINISTRATION";
String get menuCPanelUserLoginTitle => languageStatus == 0 ? "Conecte-se" : "Login";
String get menuCPanelUserLostPasswordTitle => languageStatus == 0 ? "Esqueceu sua senha" : "Forgot Password";
String get menuCPanelUserLogoutTitle => languageStatus == 0 ? "Sair" : "Logout";
String get appHomeTitle => languageStatus==0 ? "Entrega rápida e confiável — em qualquer lugar, a qualquer hora.":"Fast, Reliable Delivered—Anywhere, Anytime.";
String get appMembershipTitle => languageStatus == 0 ? "Planos de assinatura" : "Subscription plans";
String get appHomeWelcome => languageStatus == 0 ? "Bem-vindo" : "Welcome";
String get appMembershipDaysPreTitle => languageStatus == 0 ? "Você tem" : "You have";
String get appMembershipDaysSubTitle => languageStatus == 0 ? "dias de assinatura" : "subscription days";
String get appMembershipDays0Title => languageStatus == 0 ? "Você não tem mais dias de assinatura." : "You have no more subscription days.";
String get menuCPanelUserAddTitle => languageStatus == 0 ? "Novo usuário" : "New User";
String get menuCPanelUserListTitle => languageStatus == 0 ? "Usuárias" : "Users";
String get menuABMListTitle => languageStatus == 0 ? "MANUTENÇÃO" : "MAINTENANCE";
String get menuParameterTitle => languageStatus == 0 ? "Parâmetros" : "Parameters";
String get menuProfilerAdministratorMembershipListTitle => languageStatus == 0 ? "Associações" : "Memberships";
String get abmBackPressedTitle => languageStatus == 0 ? "Editar" : "Edit";
String get abmBackPressedContent => languageStatus == 0 ? "Tem certeza de que deseja sair?" : "Are you sure you want to exit?";
String get abmBackPressedNo => languageStatus == 0 ? "Não" : "No";
String get abmBackPressedYes => languageStatus == 0 ? "Sim" : "Yes";
String get abmDeleteTitle => languageStatus == 0 ? "Excluir" : "Delete";
/////////////--------------------PT---------------------////////////////////

String get shareText => languageStatus == 0
    ? "Estoy usando MD Exam para enterarte de lo ultimo de examenes, puedes bajar la app en Google Play o Apple Store"
    : "I'm using MD Exam to stay updated on the latest exams. You can download the app from Google Play or Apple Store";

const Color primaryColor = Color.fromRGBO(2, 82, 145, 1);
const Color gridTitleColor = Colors.white;
const Color customBackcolor = Color.fromRGBO(254, 254, 254, 1);
const Color customAppBarColor = Color.fromRGBO(10, 38, 202, 1);

String get preferenceIsLogin => "isLogin";
String get preferenceLoginUsername => "LoginUsername";




String get abmDeleteAlertTitle => languageStatus == 0 ? "Registro" : "Record";
String get abmDeleteAlertContent => languageStatus == 0 ? "¿Desea borrar el registro?" : "Do you want to delete the record?";
String get abmDeleteAlertPressedNo => languageStatus == 0 ? "No" : "No";
String get abmDeleteAlertPressedYes => languageStatus == 0 ? "Si" : "Yes";
String get userLoginTitle => languageStatus == 0 ? "Iniciar sesión" : "Login";
String get userLoginFieldUsernameHint => languageStatus == 0 ? "¿Cuál es su email?" : "What is your email?";
String get userLoginFieldUsernameLabel => languageStatus == 0 ? "Email *" : "Email *";
String get userLoginFieldUsernameError => languageStatus == 0 ? "Debe ingresar un email" : "You must enter an email";
String get userLoginFieldPasswordHint => languageStatus == 0 ? "¿Cual es su contraseña?" : "What is your password?";
String get userLoginFieldPasswordLabel => languageStatus == 0 ? "Contraseña *" : "Password *";
String get userLoginFieldPasswordError => languageStatus == 0 ? "Debe ingresar una contraseña" : "You must enter a password";

String get userLostPasswordTitle => languageStatus == 0 ? "Recuperar Contraseña" : "Recover Password";
String get userLostPasswordSendPassword => languageStatus == 0 ? "Te enviamos las instrucciones para recuperar tu contraseña" : "We sent you the instructions to recover your password";
String get userLostPasswordFieldUsernameHint => languageStatus == 0 ? "¿Cuál es su email?" : "What is your email?";
String get userLostPasswordFieldUsernameLabel => languageStatus == 0 ? "Email *" : "Email *";
String get userLostPasswordFieldUsernameError => languageStatus == 0 ? "Debe ingresar un email" : "You must enter an email";

String get userListTitle => languageStatus == 0 ? "Usuarios" : "Users";

String get userABMTitle => languageStatus == 0 ? "Usuario" : "User";
String get userABMSaveTitle => languageStatus == 0 ? "Guardar" : "Save";
String get userABMNewSaved => languageStatus == 0 ? "Usuario creado correctamente" : "User created successfully";
String get userABMModifySaved => languageStatus == 0 ? "Usuario modificado correctamente" : "User updated successfully";
String get userABMModifyDelete => languageStatus == 0 ? "Usuario borrado correctamente" : "User deleted successfully";
String get userABMFieldCanListUsersLabel => languageStatus == 0 ? "Puede trabajar con Lista de Usuarios" : "Can manage User List";
String get userABMFieldEnabledLabel => languageStatus == 0 ? "Habilitado" : "Enabled";
String get userABMFieldIsAdministratorLabel => languageStatus == 0 ? "Es Administrador" : "Is Administrator";

String get userABMFieldIsCustomerLabel => languageStatus == 0 ? "Es Cliente" : "Is Customer";
String get userDocumentABMFieldTitleHint => languageStatus == 0 ? "Titulo" : "Title";


const String userABMNewNotSelectTypeError =
    "Debe indicar si es Administrador/Manager/Delivery/Cliente";

const String firebaseCustomUserKey = "/appusers";
const String firebaseCustomUserMembershipKey = "/appusermemberships";
const String firebaseCustomUserMembershipPurchaseKey =
    "/appusermembershippurchases";

const String firebaseCustomParameterKey = "/parameters";
const String firebaseCustomMembershipKey = "/memberships";

//////////////////////

String get parameterListTitle => menuParameterTitle;
String get parameterABMTitle => languageStatus == 0 ? "Parámetro" : "Parameter";
String get parameterABMSaveTitle => languageStatus == 0 ? "Guardar" : "Save";
String get parameterABMNewSaved => languageStatus == 0 ? "Parámetro creado correctamente" : "Parameter created successfully";
String get parameterABMModifySaved => languageStatus == 0 ? "Parámetro modificado correctamente" : "Parameter updated successfully";
String get parameterABMModifyDelete => languageStatus == 0 ? "Parámetro borrada correctamente" : "Parameter deleted successfully";
String get parameterABMFieldKey2Hint => languageStatus == 0 ? "¿Como se llama la clave?" : "What is the key name?";
String get parameterABMFieldKey2Label => languageStatus == 0 ? "Clave" : "Key";
String get parameterABMFieldKey2Error => languageStatus == 0 ? "Debe ingresar la clave" : "You must enter the key";
String get parameterABMFieldTitleHint => languageStatus == 0 ? "¿Como se llama el parámetro?" : "What is the parameter name?";
String get parameterABMFieldTitleLabel => languageStatus == 0 ? "Descripción" : "Description";
String get parameterABMFieldTitleError => languageStatus == 0 ? "Debe ingresar una descripción" : "You must enter a description";
String get parameterABMFieldAdditionalHint => languageStatus == 0 ? "¿Como se llama el texto adicional?" : "What is the additional text?";
String get parameterABMFieldAdditionalLabel => languageStatus == 0 ? "Texto Adicional" : "Additional Text";
String get parameterABMFieldAdditionalError => languageStatus == 0 ? "Debe ingresar el texto adicional" : "You must enter additional text";

String get customerFooterCaption => languageStatus == 0 ? "No somos una institución gubernamental" : "We are not a governmental institution";

String get administratorHomeTitle => languageStatus == 0 ? "Resumén" : "Summary";
String get administratorHomePaymentPendients => languageStatus == 0 ? "Pagos Pendientes" : "Pending Payments";

String get userSimpleAddTitle => languageStatus == 0 ? "Nuevo Usuario" : "New User";

String get userSimpleAddFieldNameHint => languageStatus == 0 ? "Nombre" : "Name";
String get userSimpleAddFieldNameLabel => languageStatus == 0 ? "Nombre:" : "Name:";
String get userSimpleAddFieldNameError => languageStatus == 0 ? "Ingrese el nombre" : "Enter the name";

String get userSimpleAddFieldLastNameHint => languageStatus == 0 ? "Apellido" : "Last Name";
String get userSimpleAddFieldLastNameLabel => languageStatus == 0 ? "Apellido:" : "Last Name:";
String get userSimpleAddFieldLastNameError => languageStatus == 0 ? "Ingrese el apellido" : "Enter the last name";

String get userSimpleAddFieldUsernameHint => languageStatus == 0 ? "Correo electrónico" : "Email";
String get userSimpleAddFieldUsernameLabel => languageStatus == 0 ? "Correo electrónico:" : "Email:";
String get userSimpleAddFieldUsernameError => languageStatus == 0 ? "Ingrese el correo electrónico" : "Enter the email address";

String get userSimpleAddFieldPasswordHint => languageStatus == 0 ? "Contraseña" : "Password";
String get userSimpleAddFieldPasswordLabel => languageStatus == 0 ? "Contraseña:" : "Password:";
String get userSimpleAddFieldPasswordError => languageStatus == 0 ? "Ingrese la contraseña" : "Enter the password";

String get userSimpleAddNewSaving => languageStatus == 0 ? "Creando usuario" : "Creating user";
String get userSimpleAddNewSaved => languageStatus == 0 ? "Usuario creado correctamente" : "User created successfully";
String get userSimpleAddSaveTitle => languageStatus == 0 ? "Crear" : "Create";

String get administratorHomeArtistActives => languageStatus == 0 ? "Artistas" : "Artists";
String get administratorHomeStreamingPlatformUpdates => languageStatus == 0 ? "Subidas" : "Uploads";

const String albumNewFieldRemixOrVersionHintText =
    "Ingrese EN VIVO o EN ESTUDIO";

String get paymentConfirmResponseMessageTitle => languageStatus == 0 ? "Mensaje" : "Message";
String get paymentConfirmCloseButtonTitle => languageStatus == 0 ? "Cerrar" : "Close";



String get showDialogOkCaption => languageStatus == 0 ? "OK" : "OK";


String get membershipABMFieldTitleHint => languageStatus == 0 ? "¿Titulo de la membresia?" : "Membership title?";
String get membershipABMFieldTitleLabel => languageStatus == 0 ? "Título" : "Title";
String get membershipABMFieldTitleError => languageStatus == 0 ? "Debe ingresar un título" : "You must enter a title";

String get membershipABMFieldDetailHint => languageStatus == 0 ? "¿Detalles?" : "Details?";
String get membershipABMFieldDetailLabel => languageStatus == 0 ? "Detalles" : "Details";
String get membershipABMFieldDetailError => languageStatus == 0 ? "Debe ingresar un detalle" : "You must enter details";

String get membershipABMFieldPriceHint => languageStatus == 0 ? "¿precio?" : "Price?";
String get membershipABMFieldPriceLabel => languageStatus == 0 ? "Precio" : "Price";
String get membershipABMFieldPriceError => languageStatus == 0 ? "Debe ingresar un precio" : "You must enter a price";

String get membershipABMFieldMaxTracksError => languageStatus == 0 ? "Debe ingresar un máximo de usos" : "You must enter the maximum uses";

String get membershipABMFieldIsVisibleLabel => languageStatus == 0 ? "Es visible" : "Is visible";

String get membershipListTitle => languageStatus == 0 ? "Tus membresias" : "Your Memberships";
String get membershipABMTitle => languageStatus == 0 ? "Membresia" : "Membership";
String get membershipABMSaveTitle => languageStatus == 0 ? "Guardar" : "Save";
String get membershipABMNewSaved => languageStatus == 0 ? "Membresia creada correctamente" : "Membership created successfully";
String get membershipABMModifySaved => languageStatus == 0 ? "Membresia modificada correctamente" : "Membership updated successfully";
String get membershipABMModifyDelete => languageStatus == 0 ? "Membresia borrada correctamente" : "Membership deleted successfully";

String get membershipSaving => languageStatus == 0 ? "Guardando membresia" : "Saving membership";

String get membershipSelectTitle => languageStatus == 0 ? "Seleccionar" : "Select";
String get membershipSelectNewTitle => languageStatus == 0 ? "Crear cuenta" : "Create Account";

String get membershipPurchaseTitle => languageStatus == 0 ? "Comprar Planes de suscripción" : "Purchase subscription plans";

String get membershipPurchaseSaving => languageStatus == 0 ? "Comprando" : "Processing purchase";
String get membershipPurchasePaymentCardTitle => languageStatus == 0 ? "Tarjeta" : "Card";
String get membershipPurchasePaymentPayPalTitle => languageStatus == 0 ? "Paypal" : "Paypal";
String get questionTodoSaving => languageStatus == 0 ? "Accediendo" : "Accessing";

String get paymentViewConfirmateSaved => languageStatus == 0 ? "Compra confirmada" : "Purchase confirmed";

String get userMembershipPurchaseStatusModelValuePendingCaption => languageStatus == 0 ? "Pendiente" : "Pending";
String get userMembershipPurchaseStatusModelValueEndCaption => languageStatus == 0 ? "Finalizado" : "End";
String get userMembershipPurchaseStatusModelValueCancelCaption => languageStatus == 0 ? "Cancelado" : "Cancel";

String get userMembershipPurchasePendingError => languageStatus == 0 ? "Error, esta compra esta finalizada" : "Error, this purchase has ended";