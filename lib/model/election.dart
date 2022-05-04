class Election {
  var name, District, local, Post, Party, Ward, Provience;
  Election.fromJson(Map<String, dynamic> json)
      : name = json['Candidate'],
        District = json['District'],
        local = json['Local Body'],
        Post = json['Post'],
        Party = json['Party'],
        Ward = json['Ward No'],
        Provience = json['Provience'];
}
