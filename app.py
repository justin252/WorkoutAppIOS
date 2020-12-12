import json

from db import db
from db import Workouts, Exercise
from flask import Flask
from flask import request

db_filename = "workout.db"
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
    return success_response([t.seralize() for t in Workouts.query.all()])

@app.route("/workouts/", methods=["POST"])
def create_workout():
    body = json.loads(request.data)
    new_workout = Workouts(date = body.get('date'), notes = body.get('notes'))
    db.session.add(new_workout)
    db.session.commit()
    return success_response(new_workout.serialize(), 201)

@app.route("/workouts/<int:workout_id>/", methods=["DELETE"])
def delete_task(workout_id):
    workout = Workouts.query.filter_by(id=Workout_id).first()
    if workout is None:
        return failure_response("Task not found!")
    db.session.delete(workout)
    db.session.commit()
    return success_response(workout.serialize())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
