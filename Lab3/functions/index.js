const functions = require("firebase-functions");
const admin = require("firebase-admin");
const fetch = require("node-fetch");

admin.initializeApp();


exports.dailyRandomRecipe = functions.https.onRequest(async (req, res) => {
  console.log("Triggering daily random recipe notification");

  try {
    const response = await fetch("https://www.themealdb.com/api/json/v1/1/random.php");
    const data = await response.json();
    const recipe = data.meals[0].strMeal;

    const message = {
      topic: "recipes",
      notification: {
        title: "Рецепт на денот",
        body: recipe
      }
    };

    await admin.messaging().send(message).catch(err => console.log("Simulated send:", err.message));

    console.log("Notification sent:", recipe);
    res.status(200).send("Notification simulated: " + recipe);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error: " + error.message);
  }
});
