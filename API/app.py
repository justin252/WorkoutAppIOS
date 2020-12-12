import json

from db import db
from db import Session, Exercise, Sets
from flask import Flask
from flask import request

db_filename = "workouts.db"
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
@app.route("/sessions/")
def get_sessions():
    return success_response([t.serialize() for t in Session.query.all()])

@app.route ("/sets/")
def get_sets():
    return success_response([t.serialize() for t in Sets.query.all()])

@app.route ("/exercises/")
def get_exercises():
    return success_response([t.serialize() for t in Exercise.query.all()])

@app.route("/sessions/", methods=["POST"])
def create_session():
    body = json.loads(request.data)
    new_session = Session(date = body.get('date'), notes = body.get('notes'))
    db.session.add(new_session)
    db.session.commit()
    return success_response(new_session.serialize(), 201)

@app.route("/sessions/<int:session_id>/", methods=["POST"])
def update_session(session_id):
    body = json.loads(request.data)
    session = Session.query.filter_by(id = session_id).first()
    if session is None:
        return failure_response('Session not found')
    session.date = body.get('date', session.date)
    session.notes = body.get('notes', session.notes)
    db.session.commit()
    return success_response(session.serialize())

@app.route("/sessions/<int:session_id>/exercise/<int:exercise_id>/", methods=["POST"])
def update_exercise(session_id, exercise_id):
    body = json.loads(request.data)
    session = Session.query.filter_by(id = session_id).first()
    if session is None:
        return failure_response('Session not found!')
    exercise = Exercise.query.filter_by(id = exercise_id).first()
    if exercise is None:
        return failure_response('Exercise not found!')
    exercise.name = body.get('name', exercise.name)
    db.session.commit()
    return success_response(session.serialize())

@app.route("/sessions/<int:session_id>/exercise/<int:exercise_id>/sets/<int:sets_id>/" , methods=["POST"])
def update_sets(session_id, exercise_id, sets_id):
    body = json.loads(request.data)
    session = Session.query.filter_by(id = session_id).first()
    if Session is None:
        return failure_response('Session not found!')
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
    return success_response(session.serialize())

@app.route("/sessions/<int:session_id>/", methods=["DELETE"])
def delete_session(session_id):
    session = Session.query.filter_by(id=Session_id).first()
    if Session is None:
        return failure_response("Session not found!")
    db.session.delete(session)
    db.session.commit()
    return success_response(session.serialize())

@app.route("/sessions/<int:session_id>/exercises/", methods=["POST"])
def assign_exercises(session_id):
    session = Session.query.filter_by(id = session_id).first()
    if Session is None:
        return failure_response('Session not found!')
    body = json.loads(request.data)
    name = body.get('name')
    exercise = Exercise.query.filter_by(name = name).first()
    if exercise is None:
        exercise = Exercise(name = name)
    session.exercises.append(exercise)
    db.session.commit()
    return success_response(session.serialize())

@app.route("/sessions/<int:session_id>/exercises/<int:exercise_id>/", methods=["POST"])
def assign_sets(session_id, exercise_id):
    session = Session.query.filter_by(id = session_id).first()
    if Session is None:
        return failure_response('Session not found!')
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
    app.run(host="0.0.0.0", port=5000, debug=True)
