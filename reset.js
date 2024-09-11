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
