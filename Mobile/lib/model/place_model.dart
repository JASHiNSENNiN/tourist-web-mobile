class PlaceInfo{
  final String location, image, name, desc;

  PlaceInfo ({
    required this.desc,
    required this.name,
    required this.image,
    required this.location,
    

  });
}

List places =[
  PlaceInfo(
    image: 'assets/images/tagtay.jpg',
    location: "Tagaytay",
    name: 'Taal View',
    desc: "Taal Volcano, one of the Philippines' most active volcanoes, is situated in the middle of Taal Lake. Visitors can enjoy breathtaking views from Tagaytay Ridge or take a boat ride across the lake to hike up the volcano itself. The scenic landscapes and the unique geological features make it a must-visit spot."
  ),
  PlaceInfo(
    image: 'assets/images/siargao1-img.jpg',
    location: "Siargao",
    name: 'Cloud 9', 
    desc: "Famous worldwide for its powerful surf break, Cloud 9 is a top destination for surfers. It hosts international surfing competitions and offers a picturesque wooden boardwalk and viewing deck where visitors can watch the waves and surfers in action."

  ),
  PlaceInfo(
    image: 'assets/images/baguio.jpg',
    location: "Baguio",
    name: 'Burnham Park',
    desc: "Named after the city's planner, Daniel Burnham, this park is the heart of Baguio City. It features a large man-made lake where visitors can enjoy boat rides, beautiful gardens, and wide open spaces for picnicking and various recreational activities."
  ),
  PlaceInfo(
    image: 'assets/images/antipolo1.jpg',
    location: "Antipolo, Rizal",
    name: 'Hinulugang Taktak',
    desc: "This historical waterfall is a prominent natural landmark in Antipolo. It's surrounded by a protected area and features picnic spots, a swimming pool, and walking paths. The falls are part of the Hinulugang Taktak Protected Landscape."
  ),
  PlaceInfo(
    image: 'assets/images/ilocos2-1.jpg',
    location: "Ilocos Sur",
    name: 'Vigan Heritage Village',
    desc: "A UNESCO World Heritage site, Vigan Heritage Village is famous for its well-preserved Spanish colonial and Asian architecture. Cobblestone streets, historical houses, and horse-drawn carriages give visitors a glimpse into the Philippines' colonial past."
  ),
  

];