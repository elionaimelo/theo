import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorMessages {
  ErrorMessages({
    this.VALIDATION_ERROR = 'Tem campos preenchidos incorretamente!',
    this.REQUIRED = 'Esse campo é obrigatório!',
    this.INVALID_EMAIL = 'O email digitado é inválido!',
    this.INVALID_PASSWORD = 'A senha digitada é inválida!',
    this.PASSWORD_MIN_LENGTH = 'A senha deve ter no mínimo 6 caracteres',
    this.INVALID_MATCH_PASSWORD = 'As senhas não conferem!',
    this.NEXT_POSTS_REQUEST_ERROR = 'Erro ao carregar os posts seguintes!',
    this.RESQUEST_ERROR = 'Falha ao fazer a requisição',
    this.PICK_IMAGE_ERROR = 'Falha ao selecionar a imagem',
    this.OPEN_LINK_ERROR = 'Não foi possível abrir o link',
  });

  static ErrorMessages of(BuildContext context) {
    var _locale = AppLocalizations.of(context)!;

    return ErrorMessages(
      VALIDATION_ERROR: _locale.validationError,
      REQUIRED: _locale.required,
      INVALID_EMAIL: _locale.invalidEmail,
      INVALID_PASSWORD: _locale.invalidPassword,
      PASSWORD_MIN_LENGTH: _locale.passwordMinLength,
      INVALID_MATCH_PASSWORD: _locale.invalidMatchPassword,
      NEXT_POSTS_REQUEST_ERROR: _locale.nextPostsRequestError,
      RESQUEST_ERROR: _locale.requestError,
      PICK_IMAGE_ERROR: _locale.pickImageError,
      OPEN_LINK_ERROR: _locale.openLinkError,
    );
  }

  String VALIDATION_ERROR;
  String REQUIRED;
  String INVALID_EMAIL;
  String INVALID_PASSWORD;
  String PASSWORD_MIN_LENGTH;
  String INVALID_MATCH_PASSWORD;
  String NEXT_POSTS_REQUEST_ERROR;
  String RESQUEST_ERROR;
  String PICK_IMAGE_ERROR;
  String OPEN_LINK_ERROR;
}
