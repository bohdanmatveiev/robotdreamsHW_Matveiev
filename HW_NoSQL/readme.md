1. Створення бази даних та колекцій:
   створив бд за допомогою команди use gymDatabase
   створив колекції за допомогою команди
   gymDatabase> db.createCollection("clients")
{ ok: 1 }
gymDatabase> db.createCollection("memberships")
{ ok: 1 }
gymDatabase> db.createCollection("workouts")
{ ok: 1 }
gymDatabase> db.createCollection("trainers")
{ ok: 1 }

2. визначив схеми документів і заповнив їх даними:
   gymDatabase> db.clients.insertMany([ { client_id: 1, name: "Bohdan Matveiev", age: 33, email: "bohdan.matveiev@gmail.com" }, { client_id: 2, name: "Tetiana Matveieva", age: 31, email: "tanya.matveieva@gmail.com" }, { client_id: 3, name: "Max Yaremenko", age: 17, email: "max.yaremenko@gmail.com" }] )
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('6984db259e991c5026628ca0'),
    '1': ObjectId('6984db259e991c5026628ca1'),
    '2': ObjectId('6984db259e991c5026628ca2')
  }
}
gymDatabase> db.memberships.insertMany([ {membership_id: 1, client_id: 1, start_date: "2026-01-01", end_date: "2026-12-31", type: "Annual"}, {membership_id: 2, client_id: 2, start_date: "2026-02-01", end_date: "2026-08-01", type: "Half-year"}, {membership_id: 3, client_id: 3, start_date: "2026-03-01", end_date: "2026-09-01", type: "Half-year"} ])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('6984dbe89e991c5026628ca3'),
    '1': ObjectId('6984dbe89e991c5026628ca4'),
    '2': ObjectId('6984dbe89e991c5026628ca5')
  }
}
gymDatabase> db.workouts.insertMany([
... {workout_id: 1, description: "Cardio training", difficulty: "Medium"},
... {workout_id: 2, description: "Crossfit", difficulty: "Easy"},
... {workout_id: 2, description: "Strength training", difficulty: "Hard"}])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('6984dd6e9e991c5026628ca6'),
    '1': ObjectId('6984dd6e9e991c5026628ca7'),
    '2': ObjectId('6984dd6e9e991c5026628ca8')
  }
}
gymDatabase> db.trainers.insertMany([ {trainer_id: 1, name: "Serhiy Bondar", specialization: "Cardio"}, {trainer_id: 2, name: "Kateryna Lysenko", specialization: "Strength"}, {trainer_id: 3, name: "Mykola Horbunov", specialization: "Crossfit"} ])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('6984dd7f9e991c5026628ca9'),
    '1': ObjectId('6984dd7f9e991c5026628caa'),
    '2': ObjectId('6984dd7f9e991c5026628cab')
  }
}

3. Запити:
  * Знайдіть всіх клієнтів віком понад 30 років
gymDatabase> db.clients.find({age: {$gt: 30}})
[
  {
    _id: ObjectId('6984db259e991c5026628ca0'),
    client_id: 1,
    name: 'Bohdan Matveiev',
    age: 33,
    email: 'bohdan.matveiev@gmail.com'
  },
  {
    _id: ObjectId('6984db259e991c5026628ca1'),
    client_id: 2,
    name: 'Tetiana Matveieva',
    age: 31,
    email: 'tanya.matveieva@gmail.com'
  }
]
  * Перелічіть тренування із середньою складністю
gymDatabase> db.workouts.find({difficulty: "Medium"})
[
  {
    _id: ObjectId('6984dd6e9e991c5026628ca6'),
    workout_id: 1,
    description: 'Cardio training',
    difficulty: 'Medium'
  }
]
  * Покажіть інформацію про членство клієнта з певним client_id
gymDatabase> db.memberships.find({client_id:1})
[
  {
    _id: ObjectId('6984dbe89e991c5026628ca3'),
    membership_id: 1,
    client_id: 1,
    start_date: '2026-01-01',
    end_date: '2026-12-31',
    type: 'Annual'
  }
]
