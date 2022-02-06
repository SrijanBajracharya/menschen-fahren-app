class DateHelper{

  static Age findDateDifference(DateTime date){
    final now = new DateTime.now();

    int years = now.year - date.year;
    int months = now.month - date.month;
    int days = now.day - date.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }

    if (days < 0) {
      final monthAgo = new DateTime(now.year, now.month - 1, date.day);
      days = now.difference(monthAgo).inDays + 1;
    }

    return Age(years: years, months: months, days: days);
  }
}
class Age {
  int years;
  int months;
  int days;
  Age({ this.years = 0, this.months = 0, this.days = 0 });
}
