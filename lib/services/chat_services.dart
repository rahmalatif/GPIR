class ChatService {

  static String getChatId(
      String user1,
      String user2,
      ) {
    List<String> ids = [user1, user2];
    ids.sort();
    return ids.join('_');
  }

}