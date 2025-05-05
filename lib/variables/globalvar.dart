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
String get abmDeleteAlertContent => languageStatus == 0 ? "Você quer apagar o registro?" : "Do you want to delete the record?";
String get abmDeleteAlertPressedNo => languageStatus == 0 ? "Não" : "No";
String get abmDeleteAlertPressedYes => languageStatus == 0 ? "Sim" : "Yes";
String get userLoginTitle => languageStatus == 0 ? "Conecte-se" : "Login";
String get SubscriptionsTitle => languageStatus == 0 ? "Assinaturas" : "Subscriptions";
String get userLoginFieldUsernameHint => languageStatus == 0 ? "Qual é seu e-mail?" : "What is your email?";
String get userLoginFieldUsernameLabel => languageStatus == 0 ? "Email *" : "Email *";
String get userLoginFieldUsernameError => languageStatus == 0 ? "Você deve inserir um e-mail" : "You must enter an email";
String get userLoginFieldPasswordHint => languageStatus == 0 ? "Qual é sua senha?" : "What is your password?";
String get userLoginFieldPasswordLabel => languageStatus == 0 ? "Senha *" : "Password *";
String get userLoginFieldPasswordError => languageStatus == 0 ? "Você deve digitar uma senha" : "You must enter a password";

String get userLostPasswordTitle => languageStatus == 0 ? "Recuperar senha" : "Recover Password";
String get userLostPasswordSendPassword => languageStatus == 0 ? "Enviamos-lhe as instruções para recuperar a sua senha" : "We sent you the instructions to recover your password";
String get userLostPasswordFieldUsernameHint => languageStatus == 0 ? "Qual é seu e-mail?" : "What is your email?";
String get userLostPasswordFieldUsernameLabel => languageStatus == 0 ? "Email *" : "Email *";
String get userLostPasswordFieldUsernameError => languageStatus == 0 ? "Você deve inserir um e-mail" : "You must enter an email";

String get userListTitle => languageStatus == 0 ? "Usuárias" : "Users";

String get userABMTitle => languageStatus == 0 ? "Usuária" : "User";
String get userABMSaveTitle => languageStatus == 0 ? "Salvar" : "Save";
String get userABMNewSaved => languageStatus == 0 ? "Usuário criado com sucesso" : "User created successfully";
String get userABMModifySaved => languageStatus == 0 ? "Usuário atualizado com sucesso" : "User updated successfully";
String get userABMModifyDelete => languageStatus == 0 ? "Usuário excluído com sucesso" : "User deleted successfully";
String get userABMFieldCanListUsersLabel => languageStatus == 0 ? "Pode gerenciar a lista de usuários" : "Can manage User List";
String get userABMFieldEnabledLabel => languageStatus == 0 ? "Habilitada" : "Enabled";
String get userABMFieldIsAdministratorLabel => languageStatus == 0 ? "É Administrador" : "Is Administrator";

String get userABMFieldIsCustomerLabel => languageStatus == 0 ? "É cliente" : "Is Customer";
String get userDocumentABMFieldTitleHint => languageStatus == 0 ? "Título" : "Title";


const String userABMNewNotSelectTypeError =
    "Deve indicar se é Administrador/Gerente/Entrega/Cliente";

const String firebaseCustomUserKey = "/appusers";
const String firebaseCustomUserMembershipKey = "/appusermemberships";
const String firebaseCustomUserMembershipPurchaseKey =
    "/appusermembershippurchases";

const String firebaseCustomParameterKey = "/parameters";
const String firebaseCustomMembershipKey = "/memberships";

//////////////////////

String get parameterListTitle => menuParameterTitle;
String get parameterABMTitle => languageStatus == 0 ? "Parâmetro" : "Parameter";
String get parameterABMSaveTitle => languageStatus == 0 ? "Guardar" : "Save";
String get parameterABMNewSaved => languageStatus == 0 ? "Parâmetro criado com sucesso" : "Parameter created successfully";
String get parameterABMModifySaved => languageStatus == 0 ? "Parâmetro atualizado com sucesso" : "Parameter updated successfully";
String get parameterABMModifyDelete => languageStatus == 0 ? "Parâmetro excluído com sucesso" : "Parameter deleted successfully";
String get parameterABMFieldKey2Hint => languageStatus == 0 ? "Qual é o nome da chave?" : "What is the key name?";
String get parameterABMFieldKey2Label => languageStatus == 0 ? "Chave" : "Key";
String get parameterABMFieldKey2Error => languageStatus == 0 ? "Você deve inserir a chave" : "You must enter the key";
String get parameterABMFieldTitleHint => languageStatus == 0 ? "Qual é o nome do parâmetro?" : "What is the parameter name?";
String get parameterABMFieldTitleLabel => languageStatus == 0 ? "Descrição" : "Description";
String get parameterABMFieldTitleError => languageStatus == 0 ? "Você deve inserir uma descrição" : "You must enter a description";
String get parameterABMFieldAdditionalHint => languageStatus == 0 ? "O que é o texto adicional?" : "What is the additional text?";
String get parameterABMFieldAdditionalLabel => languageStatus == 0 ? "Texto adicional" : "Additional Text";
String get parameterABMFieldAdditionalError => languageStatus == 0 ? "Você deve inserir texto adicional" : "You must enter additional text";

String get customerFooterCaption => languageStatus == 0 ? "Não somos uma instituição governamental" : "We are not a governmental institution";

String get administratorHomeTitle => languageStatus == 0 ? "Resumo" : "Summary";
String get administratorHomePaymentPendients => languageStatus == 0 ? "Pagamentos Pendentes" : "Pending Payments";

String get userSimpleAddTitle => languageStatus == 0 ? "Novo usuário" : "New User";

String get userSimpleAddFieldNameHint => languageStatus == 0 ? "Nome" : "Name";
String get userSimpleAddFieldNameLabel => languageStatus == 0 ? "Nome:" : "Name:";
String get userSimpleAddFieldNameError => languageStatus == 0 ? "Digite o nome" : "Enter the name";

String get userSimpleAddFieldLastNameHint => languageStatus == 0 ? "Sobrenome" : "Last Name";
String get userSimpleAddFieldLastNameLabel => languageStatus == 0 ? "Sobrenome:" : "Last Name:";
String get userSimpleAddFieldLastNameError => languageStatus == 0 ? "Digite o sobrenome" : "Enter the last name";

String get userSimpleAddFieldUsernameHint => languageStatus == 0 ? "Email" : "Email";
String get userSimpleAddFieldUsernameLabel => languageStatus == 0 ? "Email:" : "Email:";
String get userSimpleAddFieldUsernameError => languageStatus == 0 ? " Digite o endereço de e-mail" : "Enter the email address";

String get userSimpleAddFieldPasswordHint => languageStatus == 0 ? "Senha" : "Password";
String get userSimpleAddFieldPasswordLabel => languageStatus == 0 ? "Senha:" : "Password:";
String get userSimpleAddFieldPasswordError => languageStatus == 0 ? "Digite a senha" : "Enter the password";

String get userSimpleAddNewSaving => languageStatus == 0 ? "Criando usuário" : "Creating user";
String get userSimpleAddNewSaved => languageStatus == 0 ? "Usuário criado com sucesso" : "User created successfully";
String get userSimpleAddSaveTitle => languageStatus == 0 ? "Criar" : "Create";

String get administratorHomeArtistActives => languageStatus == 0 ? "Artistas" : "Artists";
String get administratorHomeStreamingPlatformUpdates => languageStatus == 0 ? "Envios" : "Uploads";

const String albumNewFieldRemixOrVersionHintText =
    "Ingrese EN VIVO o EN ESTUDIO";

String get paymentConfirmResponseMessageTitle => languageStatus == 0 ? "Mensagem" : "Message";
String get paymentConfirmCloseButtonTitle => languageStatus == 0 ? "Fechar" : "Close";



String get showDialogOkCaption => languageStatus == 0 ? "OK" : "OK";


String get membershipABMFieldTitleHint => languageStatus == 0 ? "Título de membro?" : "Membership title?";
String get membershipABMFieldTitleLabel => languageStatus == 0 ? "Título" : "Title";
String get membershipABMFieldTitleError => languageStatus == 0 ? "Você deve inserir um título" : "You must enter a title";

String get membershipABMFieldDetailHint => languageStatus == 0 ? "Detalhes?" : "Details?";
String get membershipABMFieldDetailLabel => languageStatus == 0 ? "Detalhes" : "Details";
String get membershipABMFieldDetailError => languageStatus == 0 ? "Você deve inserir detalhes" : "You must enter details";

String get membershipABMFieldPriceHint => languageStatus == 0 ? "Preço?" : "Price?";
String get membershipABMFieldPriceLabel => languageStatus == 0 ? "Preço" : "Price";
String get membershipABMFieldPriceError => languageStatus == 0 ? "Você deve inserir um preço" : "You must enter a price";

String get membershipABMFieldMaxTracksError => languageStatus == 0 ? "Você deve inserir os usos máximos" : "You must enter the maximum uses";

String get membershipABMFieldIsVisibleLabel => languageStatus == 0 ? "É visível" : "Is visible";

String get membershipListTitle => languageStatus == 0 ? "Suas Assinaturas" : "Your Memberships";
String get membershipABMTitle => languageStatus == 0 ? "Associação" : "Membership";
String get membershipABMSaveTitle => languageStatus == 0 ? "Salvar" : "Save";
String get membershipABMNewSaved => languageStatus == 0 ? "Associação criada com sucesso" : "Membership created successfully";
String get membershipABMModifySaved => languageStatus == 0 ? "Associação atualizada com sucesso" : "Membership updated successfully";
String get membershipABMModifyDelete => languageStatus == 0 ? "Associação excluída com sucesso" : "Membership deleted successfully";

String get membershipSaving => languageStatus == 0 ? "Salvando associação" : "Saving membership";

String get membershipSelectTitle => languageStatus == 0 ? "Selecione" : "Select";
String get membershipSelectNewTitle => languageStatus == 0 ? "Criar uma conta" : "Create Account";

String get membershipPurchaseTitle => languageStatus == 0 ? "Comprar planos de assinatura" : "Purchase subscription plans";

String get membershipPurchaseSaving => languageStatus == 0 ? "Processando compra" : "Processing purchase";
String get membershipPurchasePaymentCardTitle => languageStatus == 0 ? "Cartão" : "Card";
String get membershipPurchasePaymentPayPalTitle => languageStatus == 0 ? "Paypal" : "Paypal";
String get questionTodoSaving => languageStatus == 0 ? "Acessando" : "Accessing";

String get paymentViewConfirmateSaved => languageStatus == 0 ? "Compra confirmada" : "Purchase confirmed";

String get userMembershipPurchaseStatusModelValuePendingCaption => languageStatus == 0 ? "Pendente" : "Pending";
String get userMembershipPurchaseStatusModelValueEndCaption => languageStatus == 0 ? "Fim" : "End";
String get userMembershipPurchaseStatusModelValueCancelCaption => languageStatus == 0 ? "Cancelar" : "Cancel";

String get userMembershipPurchasePendingError => languageStatus == 0 ? "Erro, esta compra foi encerrada" : "Error, this purchase has ended";