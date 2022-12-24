// ignore_for_file: constant_identifier_names

class Strings {
  Strings._();

  static const String APP_NAME = "Todo App";

  static const String LABEL_UNDERSTOOD = "ENTENDI";
  static const String LABEL_DONE = "Concluída";
  static const String LABEL_PRIORITY = "Prioridade";
  static const String LABEL_PROCESSING = "Processando...";
  static const String LABEL_YES = "SIM";
  static const String LABEL_NO = "NÃO";
  static const String LABEL_SAVE = "SALVAR";
  static const String LABEL_SORT_AZ = "AZ";
  static const String LABEL_SORT_ZA = "ZA";
  static const String LABEL_SORT_HIGH_PRIORITY = "Alta Prioridade";
  static const String LABEL_SORT_LOW_PRIORITY = "Baixa Prioridade";

  static const String VALID_NOT_EMPTY = "Campo não pode ser nulo.";

  static const String BACKEND_FAILED_OPERATION =
      "Ops! Ocorreu uma falha na operação, tente novamente em breve!";
  static const String BACKEND_ITEM_NOT_FOUND = "Ops! Item não encontrado!";
  static const String BACKEND_GENERIC_ERROR =
      "Ops! Ocorreu uma falha no servidor, estamos dando uma bronca nele!";

  static const String TODO_LIST_TITLE = "Lista de Tarefas";
  static const String TODO_LIST_EMPTY = "Nenhuma tarefa cadastrada!";
  static const String TODO_LIST_VALID_TITLE_MIN_LENGTH =
      "Campo não pode ter menos de 3 caracteres.";

  static const String TODO_FORM_TITLE = "Nova Tarefa";
  static const String TODO_FORM_HINT_TASK_TITLE = "Nova tarefa...";
  static const String TODO_FORM_ALERT_SUCCESS_TITLE =
      "Cadastro de tarefa realizado com sucesso!";
  static const String TODO_FORM_ALERT_SUCCESS_MESSAGE =
      "Deseja cadastrar uma nova tarefa?";
  static const String TODO_FORM_ALERT_ERROR_TITLE = "Deu errado";
}
