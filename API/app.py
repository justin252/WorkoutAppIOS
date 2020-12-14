import json
import os

from db import db
from db import Workout, Exercise, Sets, User
from flask import Flask, url_for
from flask import request

db_filename = "app.db"
app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{db_filename}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

@app.route("/")
@app.route("/workouts/")
def get_workouts():
    return success_response([t.serialize() for t in Workout.query.all()])

@app.route ("/sets/")
def get_sets():
    return success_response([t.serialize() for t in Sets.query.all()])

@app.route ("/exercises/")
def get_exercises():
    return success_response([t.serialize() for t in Exercise.query.all()])

@app.route ("/users/")
def get_users():
    return success_response([t.serialize() for t in User.query.all()])

@app.route("/workouts/", methods=["POST"])
def create_workout():
    body = json.loads(request.data)
    new_workout = Workout(date = body.get('date'), notes = body.get('notes'))
    db.session.add(new_workout)
    db.session.commit()
    return success_response(new_workout.serialize(), 201)

@app.route("/users/", methods=["POST"])
def create_user():
    body = json.loads(request.data)
    new_user = User(username = body.get('username'), password = body.get('password'), age = body.get('age'), weight = body.get('weight'), sex = body.get('sex'))
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(), 201)

@app.route("/exercises/", methods=["POST"])
def create_exercise():
    body = json.loads(request.data)
    new_exercise = Exercise(name = body.get('name'))
    db.session.add(new_exercise)
    db.session.commit()
    return success_response(new_exercise.serialize(), 201)

@app.route("/users/<int:user_id>/", methods=["POST"])
def update_user(user_id):
    body = json.loads(request.data)
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    user.username = body.get('username', user.date)
    user.password = body.get('password', user.notes)
    user.age = body.get('age', user.age)
    user.weight = body.get('weight', user.weight)
    user.sex = body.get ('sex', user.sex)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/users/<int:user_id>/workouts/<int:workout_id>/", methods=["POST"])
def update_workout(user_id,workout_id):
    body = json.loads(request.data)
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    workout = Workout.query.filter_by(id = workout_id).first()
    if workout is None:
        return failure_response('Workout not found')
    workout.date = body.get('date', workout.date)
    workout.name = body.get('name', workout.name)
    workout.notes = body.get('notes', workout.notes)
    db.session.commit()
    return success_response(workout.serialize())

@app.route("/users/<int:user_id>/workouts/<int:workout_id>/exercise/<int:exercise_id>/", methods=["POST"])
def update_exercise(user_id, workout_id, exercise_id):
    body = json.loads(request.data)
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    workout = Workout.query.filter_by(id = workout_id).first()
    if workout is None:
        return failure_response('Workout not found!')
    exercise = Exercise.query.filter_by(id = exercise_id).first()
    if exercise is None:
        return failure_response('Exercise not found!')
    exercise.name = body.get('name', exercise.name)
    exercise.seen = body.get('seen', exercise.seen)
    db.session.commit()
    return success_response(workout.serialize())

@app.route("/users/<int:user_id>/workouts/<int:workout_id>/exercise/<int:exercise_id>/sets/<int:sets_id>/" , methods=["POST"])
def update_sets(user_id, workout_id, exercise_id, sets_id):
    body = json.loads(request.data)
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    workout = Workout.query.filter_by(id = workout_id).first()
    if Workout is None:
        return failure_response('Workout not found!')
    exercise = Exercise.query.filter_by(id = exercise_id).first()
    if exercise is None:
        return failure_response('Exercise not found!')
    sets = Sets.query.filter_by(id = sets_id).first()
    if sets is None:
        return failure_response('Sets not found!')
    sets.number = body.get('number', sets.number)
    sets.reps = body.get('reps', sets.reps)
    sets.weight = body.get('weight', sets.weight)
    db.session.commit()
    return success_response(workout.serialize())


@app.route("/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/users/<int:user_id>/workouts/<int:workout_id>/", methods=["DELETE"])
def delete_workout(user_id,workout_id):
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    workout = Workout.query.filter_by(id=workout_id).first()
    if Workout is None:
        return failure_response("Workout not found!")
    db.session.delete(workout)
    db.session.commit()
    return success_response(workout.serialize())

@app.route("/users/<int:user_id>/workouts/", methods=["POST"])
def assign_workouts(user_id):
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    body = json.loads(request.data)
    date = body.get('date')
    name = body.get('name')
    notes = body.get('notes')
    new_workout = Workout(date = date, name = name, notes = notes, user_id = user_id)
    db.session.add(new_workout)
    db.session.commit()
    return success_response(new_workout.serialize())

@app.route("/users/<int:user_id>/workouts/<int:workout_id>/exercises/", methods=["POST"])
def assign_exercises(user_id,workout_id):
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    workout = Workout.query.filter_by(id = workout_id).first()
    if Workout is None:
        return failure_response('Workout not found!')
    body = json.loads(request.data)
    name = body.get('name')
    seen = body.get('seen')
    exercise = Exercise.query.filter_by(name = name, seen = seen).first()
    if exercise is None:
        exercise = Exercise(name = name)
    workout.exercises.append(exercise)
    db.session.commit()
    return success_response(workout.serialize())

@app.route("/users/<int:user_id>/workouts/<int:workout_id>/exercises/<int:exercise_id>/sets/", methods=["POST"])
def assign_sets(user_id,workout_id, exercise_id):
    user = User.query.filter_by(id = user_id).first()
    if user is None:
        return failure_response('User not found')
    workout = Workout.query.filter_by(id = workout_id).first()
    if Workout is None:
        return failure_response('Workout not found!')
    exercise = Exercise.query.filter_by(id = exercise_id).first()
    if exercise is None:
        return failure_response('Exercise not found!')
    body = json.loads(request.data)
    number = body.get('number')
    reps = body.get('reps')
    weight = body.get('weight')
    sets = Sets.query.filter_by(number = number, reps = reps, weight = weight).first()
    if sets is None:
        sets = Sets(number = number, reps = reps, weight = weight)
    exercise.sets.append(sets)
    db.session.commit()
    return success_response(sets.serialize())


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 4000))
    app.run(host= "0.0.0.0", port= port)
