class Sgpa{
  final int sems;
  final double points;

  Sgpa({
   this.sems,
   this.points
});

  Map<String, dynamic> toMap(){
    return{
      'sems':sems,
      'sgpa':points
    };
  }

  static Sgpa fromMap(Map<String, dynamic> map){
    return Sgpa(
      sems: map['sems'],
      points: map['sgpa'],
    );
  }
}