API Specification 

All routes begin with ae385.herokuapp.com

/users/
Gets all users
Response:
{"success": true, "data": [{"id": 1, "username": "Sam21", "password": "Football21", "age": 10, "weight": "160 lb",
"sex": "Male", "workouts": []}]}

/workouts/
Gets all workouts
Response:
{"success": true, "data": [{"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 2", "exercises": [{"id": 1,
"name": "squats", "seen": false, "sets": [{"id": 1, "number": 2, "reps": 16, "weight": "160 lb"}]}]}]}

/sets/
Gets all sets
Response:
{"success": true, "data": [{"id": 1, "number": 2, "reps": 16, "weight": "160 lb"}]}

/exercises/
Get all exercises
Response:
{"success": true, "data": [{"id": 1, "name": "squats", "seen": false, "sets": [{"id": 1, "number": 2, "reps": 16,
"weight": "160 lb"}]}]}

/users/, methods=["POST"])
Creates a user
Request:
{  
    "username": "Sam21",
    "password": "Football21",
    "age" : 10,
    "weight": "160 lb",
    "sex": "Male"
}
Response:
{"success": true, "data": {"id": 1, "username": "Sam21", "password": "Football21", "age": 10, "weight": "160 lb", "sex":
"Male", "workouts": []}}

/exercises/, methods=["POST"]
Creates a exercise

/workouts/, methods=["POST"]
Creates a workout
Request
{  
    "date": "12/14/20",
    "name": "Abs",
    "notes": "Workout 1"
}
Response
{"success": true, "data": {"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 1", "exercises": []}}

/users/<int:user_id>/, methods=["POST"])
Updates a user
Request:
{
"age" : 16
}
{"success": true, "data": {"id": 1, "username": "Sam21", "password": "Football21", "age": 16, "weight": "160 lb", "sex":
"Male", "workouts": []}}

/users/<int:user_id>/workouts/<int:workout_id>/, methods=["POST"]
Updates a workout
Request:
{  
    "notes": "Workout 2"
}
Response:
{"success": true, "data": {"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 2", "exercises": []}}

/users/<int:user_id>/workouts/<int:workout_id>/exercise/<int:exercise_id>/, methods=["POST"])
Updates a exercise
Request:
{ "name": "squats" }
Response:
{"success": true, "data": {"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 2", "exercises": [{"id": 1,
"name": "squats", "seen": false, "sets": [{"id": 1, "number": 2, "reps": 16, "weight": "160 lb"}]}]}}

/users/<int:user_id>/workouts/<int:workout_id>/exercise/<int:exercise_id>/sets/<int:sets_id>, methods=["POST"])
Updates a set
Request:
{
 "number": 2
}
Response:
{"success": true, "data": {"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 2", "exercises": [{"id": 1,
"name": "benchpress", "seen": false, "sets": [{"id": 1, "number": 2, "reps": 16, "weight": "160 lb"}]}]}}

/users/<int:user_id>/workouts/<int:workout_id>/, methods=["DELETE"])
Deletes a workout
Response:
{"success": true, "data": {"id": 2, "date": "12/14/20", "name": "Abs", "notes": "Workout 2", "exercises": []}}

/users/<int:user_id>/, methods=["DELETE"]
Deletes a user
Response:
{"success": true, "data": {"id": 1, "username": "Sam21", "password": "Football21", "age": 10, "weight": "160 lb", "sex":
"Male", "workouts": [{"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 2", "exercises": [{"id": 1, "name":
"squats", "seen": false, "sets": [{"id": 1, "number": 2, "reps": 16, "weight": "160 lb"}]}]}]}}

/users/<int:user_id/workouts/, methods=["POST"])
Assigns a workout
Request:
{  
    "date": "12/14/20",
    "name": "Abs",
    "notes": "Workout 1"
}
Response:
{"success": true, "data": {"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 1", "exercises": []}}

/users/<int:user_id>/workouts/<int:workout_id>/exercises/, methods=["POST"]
Assigns a exercise
Request:
{
   "name": "benchpress"
}
Response:
{"success": true, "data": {"id": 1, "date": "12/14/20", "name": "Abs", "notes": "Workout 2", "exercises": [{"id": 1,
"name": "benchpress", "seen": false, "sets": []}]}}

/users/<int:user_id>/workouts/<int:workout_id>/workouts/<int:workout_id>/, methods=["POST"]
Assigns a set
Request:
{  
    "number": 1,
    "reps": 16,
    "weight": "160 lb"
}
Response:
{"success": true, "data": {"id": 1, "number": 1, "reps": 16, "weight": "160 lb"}}
