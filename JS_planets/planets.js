//this function is passed the planet the user clicks on and sets the image to the corresponding planet
function setImage(planet) {
  const imageCircle = document.getElementById("imageCircle");
  if(planet === "saturn") {
    imageCircle.style.backgroundImage = "url('https://www.pngmart.com/files/22/Saturn-PNG-Clipart.png')";
  }
  else {
    imageCircle.style.backgroundImage = `url('https://www.solarsystemscope.com/spacepedia/images/handbook/renders/${planet}.png')`;
}
  }
//this function is passed the planet the user clicks on finds the associating bio for that planet.
function getPlanetInfo(planet){
  if (planet === "sun") {
    return "This is the Sun, not the newspaper kind. Not a planet but its what keeps us warm.. but dont go too close!! You dont want to be so warm your flesh evaporates off your bones before yoour very own eyes.";
  }
  else if (planet === "mercury"){
    return "This is Mercury, not the metal kind. Mercury is the hottest planet in the solar system, its wayyyy to close to the sun. Not the best place to try and get a tan on, Ive tried.";
  }
  else if (planet === "venus"){
    return "This is Venus, not the womans razor kind. The roman goddess of love is named after this planet. I can see why as a day on this planet is longer than an earth year, much like some days spent with a romantic partner...";
  }
  else if (planet === "earth"){
    return "This is Earth. Its not just the soil beneath your feet, thats just a small part of this massive ecosystem!! This is the only planet (that you know of) that has produced living organisms. This is great however there are spce rumors that these living organisms are the cause of their own demise...";
  }
  else if (planet === "mars"){
    return "This is Mars, not the chocolate kind. Mars is pretty cool, Im biased cus thats where Im from (dont tell your so called FBI though, they like to tickle us 'aliens' with their 'bullets')";
  }
  else if (planet === "jupiter"){
    return "This is Jupiter, not the computing platform kind. This is the biggest planet in the solar system. Id bring your best windproof jacket if your thinking of exploring the red spot, ive heard that storms been going on for centuries.";
  }
  else if (planet === "saturn"){
    return "This is Saturn, not the cloud workspace kind. Unlike Venus a day here is 10.25 earth hours!! Now thats pretty fast, better start making a itinary fast, days gonna be over soon.";
  }
  else if (planet === "uranus"){
    return "This is Uranus, not the well... you know. Uranus is a gas giant, meaning the surface is made purly of gas.. This doesnt correspond to the given name, that I know of anyway. It has 27 moons all of which are named after Shakespeare and Alexander Pope characters.";
  }
  else if (planet === "neptune"){
    return "This is Neptune, not the... oh this one's unique. Theres not much on Neptune only that its an ice giant. Bring a jacket on this one, your gonna want it.";
  }
  else if (planet === "pluto"){
    return "This is Pluto, not the disney character kind. This one was kinda... whats a nice way to say this, kicked out of the crew. Its been rebranded a 'dwarf planet', poor thing.";
  }
  return "oHhHhhhHH nOoOOooo tHiS isN't rIgHt!! yOu'Ve fOunD aNotHer pLanEt..."; //easter egg and debugging message :)
}
//will add more of a bio in my own time, for purpose of task I have left it simple.

//this function takes the image and bio corresponding to the correct planet and displays them when the planet buttons are clicked. togglePlanet(planet) corresponds to the onclick element of the planet buttons.
function togglePlanet(planet) {
  planet = planet.toLowerCase();
  const planetInfo = document.getElementById("planetInfo");
  planetInfo.textContent = getPlanetInfo(planet);
  image = setImage(planet);
  imageCircle.style.border = "0px"; //takes away white border
}

let turn = 1; //keeps track of the number of attempt the player has used

//this function carries out the action of clicking the enter button when the user submits a guess.
function enterButton(){
  const inputBoxText = document.getElementById("inputBox").value;
  const correctAns = "earth";
  const wrongAns = ["sun", "mercury", "venus", "mars", "jupiter", "saturn", "uranus", "neptune", "pluto"];

 if (turn <= 2){  //only allows 3 guesses
    if (inputBoxText.toLowerCase() === correctAns){ //if the answer submitted is correct
      alert("YOU ARE CORRECT!! Here is a dancing alien as a reward");
      const imageCircle = document.getElementById("imageCircle");
      imageCircle.style.backgroundImage = "url('https://media2.giphy.com/media/XVBzMyNdFQ9FJiIuYY/200w.gif?cid=82a1493br89fdss2qaps1sgem3j27n5jxzmvfw5u04pn5u3t&ep=v1_gifs_related&rid=200w.gif&ct=s')"; //fun prize
      imageCircle.style.border = "0px";
      document.getElementById("planetInfo").textContent = "WINNER!!";
    }
    else if (wrongAns.includes(inputBoxText.toLowerCase())) { //wrongANS list and toLowerCase means the it knows if you are inputing a a real planet
      alert("YOU ARE SOOOooooo WRONG!!! Try again.");
      turn++;
    }
    else {
      alert("THATS NOT A PLANET!!!! try again"); //checks for error and allows for player to retry without using an attempt
    }
  
  }
  else {
    let message = ""
    for (x = 0; x<=104; x++){
      message += "LOSER!!"; //prints loser repeatedly without spaces in alert box to inform user they are a loser.
    }
    alert(message)
    document.getElementById("enterButton").remove();
    document.getElementById("inputBox").remove();
    document.getElementById("choosePlanet").textContent = "Sorry Buddy. No more guesses";
    //removes input box and button so user cannot attempt again
  }
}

let nightMode = true; //always starts on nightmode

//this function allows for switches between day and night mode using the toggleDayNight button.
function toggleDayNight(){
  nightMode = !nightMode; //onclick night mode becomes not night mode
  if (!nightMode){ //if not night mode (day mode)
    document.getElementById("toggleDayNight").textContent = "Day Mode";
    document.getElementById("container").style.backgroundImage = "url('https://img.itch.zone/aW1hZ2UvNzY1NzU4LzQyODM0ODEucG5n/original/lr6daI.png')";
    document.getElementById("heading").style.color = "black";
    const text = document.getElementsByClassName("text");
    for (i = 0; i < text.length; i++) {
        text[i].style.color="black";
      //changes text colour and background for day mode style.
    }
  }
  
  if (nightMode) { //if night mode
    document.getElementById("toggleDayNight").textContent = "Night Mode";
    document.getElementById("container").style.backgroundImage = "url('https://cdn.dribbble.com/users/9987510/screenshots/17080253/media/a796fc5a022e978a1fc09d0e82a0d98b.gif')";
    document.getElementById("heading").style.color = "whitesmoke";
    const text = document.getElementsByClassName("text");
    for (i = 0; i < text.length; i++) {
        text[i].style.color="whitesmoke";
      //changes text colour and background for nightmode format
    }
  }
}