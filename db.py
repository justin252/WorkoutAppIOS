from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

'''
association_table = db.Table(
    'association',
    db.Model.metadata,
    db.Column('workouts_id', db.Integer, db.ForeignKey('workouts.id')),
    db.Column('exercise_id', db.Integer, db.ForeignKey("exercise.id"))
)
'''

class Workouts(db.Model):
    __tablename__ = "workouts"
    id = db.Column(db.Integer, primary_key = True)
    date = db.Column(db.String(50))
    notes = db.Column(db.Text)

    def __init__(self, **kwargs):
        self.date = kwargs.get("date", ' ')
        self.notes = kwargs.get('notes', False)

    def serialize(self):
        return {
            'id': self.id,
            'date': self.date,
            'notes': self.notes
        }

class Exercise(db.Model):
    __tablename__ = 'exercise'
    id = db.Column(db.Integer, primary_key = True)
    name = db.Column(db.String(50))

    def __init__(self, **kwargs):
        self.name = kwargs.get("name", ' ')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.description
        }

class Sets(db.Model):
    __tablename__ = 'sets'
    id = db.Column(db.Integer, primary_key = True)
