from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

set_exercise = db.Table(
    'set_exercise',
    db.Model.metadata,
    db.Column('sets_id', db.Integer, db.ForeignKey('sets.id')),
    db.Column('exercise_id', db.Integer, db.ForeignKey("exercise.id")),
)

exercise_workout = db.Table(
    'exercise_workout',
    db.Model.metadata,
    db.Column('exercise_id', db.Integer, db.ForeignKey('exercise.id')),
    db.Column('workout_id', db.Integer, db.ForeignKey("workout.id")),
)

class User(db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String(10))
    password = db.Column(db.String(10))
    age = db.Column(db.Integer)
    weight = db.Column(db.String(10))
    sex =  db.Column(db.Text)
    workouts = db.relationship("Workout", cascade="delete")
    
    def __init__(self, **kwargs):
        self.username = kwargs.get('username', ' ')
        self.password = kwargs.get('password', ' ')
        self.age = kwargs.get('age', ' ')
        self.weight = kwargs.get('weight', ' ')
        self.sex = kwargs.get('sex', ' ')

    def serialize(self):
        return {
            'id': self.id,
            'username': self.username,
            'password': self.password,
            'age': self.age,
            'weight': self.weight,
            'sex': self.sex,
            'workouts': [s.serialize() for s in self.workouts]
        }

class Workout(db.Model):
    __tablename__ = "workout"
    id = db.Column(db.Integer, primary_key = True)
    date = db.Column(db.String(50))
    name = db.Column(db.String(20))
    notes = db.Column(db.Text)
    exercises = db.relationship("Exercise", secondary = exercise_workout, back_populates = 'workouts')
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    
    def __init__(self, **kwargs):
        self.date = kwargs.get("date", ' ')
        self.name = kwargs.get("name", ' ')
        self.notes = kwargs.get('notes', ' ')
        self.user_id = kwargs.get('user_id',' ')

    def serialize(self):
        return {
            'id': self.id,
            'date': self.date,
            'name': self.name,
            'notes': self.notes,
            'exercises': [s.serialize() for s in self.exercises]
        }

class Exercise(db.Model):
    __tablename__ = 'exercise'
    id = db.Column(db.Integer, primary_key = True)
    name = db.Column(db.String(50))
    seen = db.Column(db.Boolean, nullable = False)
    workouts = db.relationship("Workout", secondary = exercise_workout, back_populates = 'exercises')
    sets = db.relationship("Sets", secondary = set_exercise, back_populates = 'exercises')

    def __init__(self, **kwargs):
        self.name = kwargs.get("name", ' ')
        self.seen = kwargs.get("seen", False)

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'seen': self.seen,
            'sets' : [s.serialize() for s in self.sets]
        }

class Sets(db.Model):
    __tablename__ = 'sets'
    id = db.Column(db.Integer, primary_key = True)
    exercises = db.relationship("Exercise", secondary = set_exercise, back_populates = 'sets')
    number = db.Column(db.Integer)
    reps = db.Column(db.Integer)
    weight = db.Column(db.String(10))

    def __init__(self, **kwargs):
        self.number = kwargs.get('number', ' ')
        self.reps = kwargs.get("reps", ' ')
        self.weight = kwargs.get("weight", ' ')

    def serialize(self):
        return {
            'id': self.id,
            'number': self.number,
            'reps': self.reps,
            'weight': self.weight
        }

