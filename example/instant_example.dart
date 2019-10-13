import 'package:instant/instant.dart';

main() {
  DateTime SanFran = dateTimeByZone(zone: "PDT"); //current DateTime in PDT timezone
  print(formatTime(time: SanFran)); //prints current time in PDT
  print(formatDate(date: SanFran)); //prints current date in PDT
}
