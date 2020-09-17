const timerStartLine = () => {
  conseole.log("HELLO");

  <button id="myBtn">Try it</button>
  document.getElementById("myBtn").addEventListener("click", displayDate);
  function displayDate() {
    document.getElementById("demo").innerHTML = Date();
  
  <button onclick="start()">Start</button>
  const startButton = document.querySelHector("start()").addEventListener("click", displayDate);
  
  var startTime, endTime;

  function start() {
    startTime = new Date();
  };

  function end() {
    endTime = new Date();
    var timeDiff = endTime - startTime; //in ms
    // strip the ms
    timeDiff /= 1000;

    // get seconds 
    var seconds = Math.round(timeDiff);
    console.log(seconds + " seconds");
  };
export { timerStartLine };

// 1. chercher button start
// 2. stocker dans une variable
// 3. ajouter event listener click
// 4. start timer