from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

set_exercise = db.Table(
    'set_exercise',
    db.Model.metadata,
    db.Column('sets_id', db.Integer, db.ForeignKey('sets.id')),
    db.Column('exercise_id', db.Integer, db.ForeignKey("exercise.id")),
)

exercise_session = db.Table(
    'exercise_session',
    db.Model.metadata,
    db.Column('exercise_id', db.Integer, db.ForeignKey('exercise.id')),
    db.Column('session_id', db.Integer, db.ForeignKey("session.id")),
)


class Session(db.Model):
    __tablename__ = "session"
    id = db.Column(db.Integer, primary_key = True)
    date = db.Column(db.String(50))
    notes = db.Column(db.Text)
    exercises = db.relationship("Exercise", secondary = exercise_session, back_populates = 'sessions')

    def __init__(self, **kwargs):
        self.date = kwargs.get("date", ' ')
        self.notes = kwargs.get('notes', ' ')

    def serialize(self):
        return {
            'id': self.id,
            'date': self.date,
            'notes': self.notes,
            'exercises': [s.serialize() for s in self.exercises]
        }

class Exercise(db.Model):
    __tablename__ = 'exercise'
    id = db.Column(db.Integer, primary_key = True)
    name = db.Column(db.String(50))
    sessions = db.relationship("Session", secondary = exercise_session, back_populates = 'exercises')
    sets = db.relationship("Sets", secondary = set_exercise, back_populates = 'exercises')

    def __init__(self, **kwargs):
        self.name = kwargs.get("name", ' ')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
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

