class Detail {

  var id;
  var title;
  var price;
  var description;
  var image_url;
  var rating;
  Detail({this.id,this.title,this.price,this.image_url,this.description,this.rating});
  Detail.fromJson(json){
    id : json['id'];
    name: json['title'];
    price:json['price'];
    description:json['description'];
    image_url:json['image_url'];
    rating: Rating.fromJson(json('rating'));

  }
}

class Rating{
  var rate;
  var count;
  Rating ({this.rate,this.count});
  Rating.fromJson(json){
    rate: json['rate'].toDouble();
    count: json['count'];
  }
}

