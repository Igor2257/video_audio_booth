enum RegisterOrSingIn{register,signIn}

enum TextClassificationEnum{
  question(0,"Запитання"),
  command(1,"Команди"),
  emotionalText(2,"Опис або емоційний текст");

  const TextClassificationEnum(this.id,this.text);
  final int id;
  final String text;

  @override
  String toString(){
    return "$id - $text";
  }
}