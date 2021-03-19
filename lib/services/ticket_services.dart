part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      'movieID': ticket.movieDetail.id,
      'userID': id ?? '',
      'theaterName': ticket.theater.name,
      'time': ticket.dateTime.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
      'movieID_time': ticket.movieDetail.id +
              000 +
              ticket.dateTime.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userId);

    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: document.data['movieID']);
      tickets.add(Ticket(
          movieDetail,
          Theater(document.data['theaterName']),
          DateTime.fromMillisecondsSinceEpoch(document.data['time']),
          document.data['bookingCode'],
          document.data['seats'].toString().split(','),
          document.data['name'],
          document.data['totalPrice']));
    }

    return tickets;
  }

  static Future<List<String>> getSeats(int time, int movieId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents.where(
        (document) => (document.data['movieID_time'] == movieId + 000 + time));

    List<String> boughtSeats = [];

    for (var document in documents) {
      boughtSeats.add(document.data['seats'].toString());
    }

    return boughtSeats;
  }
}
