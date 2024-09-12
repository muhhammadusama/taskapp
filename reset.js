const admin = require('firebase-admin');
const serviceAccount = require('./path/to/your/serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://console.firebase.google.com/u/0/project/personalhome-f172b/firestore/databases/-default-/data/~2Ftask~2Fjb3IowSQJdfs5hI5TaAB8pkuxZ72"
});

const firestore = admin.firestore();

async function resetTasks() {
  const tasksRef = firestore.collection('task');
  try {
    const snapshot = await tasksRef.get();
    snapshot.forEach(doc => {
      tasksRef.doc(doc.id).update({
        'isCompleted': false, // Reset task completion
        'taskHistory':
            taskHistory, // Update history with the task status for today
      });
    });
    console.log('Tasks have been reset successfully.');
  } catch (error) {
    console.error('Error resetting tasks:', error);
  }
}

resetTasks().then(() => process.exit(0));



/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

//const {onRequest} = require("firebase-functions/v2/https");
//const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();

// // Scheduled function to reset 'isCompleted' field daily
// exports.resetDailyTask = functions.pubsub.schedule('every day 12:34').timeZone('Asia/Karachi').onRun(async (context) => {
//   const usersCollection = admin.firestore().collection('task'); // Update with your actual collection name

//   try {
//     // Fetch all user documents
//     const snapshot = await usersCollection.get();
//     const batch = admin.firestore().batch();

//     snapshot.forEach((doc) => {
//       const userRef = usersCollection.doc(doc.id);
      
//       // Add the update operation to batch to reset 'isCompleted'
//       batch.update(userRef, {
//         isCompleted: false
//       });
//     });

//     // Commit the batch update to Firestore
//     await batch.commit();
//     console.log('Daily reset of isCompleted field completed successfully.');
//   } catch (error) {
//     console.error('Error resetting daily tasks:', error);
//   }

//   return null;
// });

