class RankHelper {

  static String getRank(int points) {

    if (points < 100) {
      return "Bronze";
    }

    if (points < 300) {
      return "Silver";
    }

    if (points < 700) {
      return "Gold";
    }

    if (points < 1500) {
      return "Elite";
    }

    return "Legend";

  }

}