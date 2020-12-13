//
//  Workout.swift
//  WorkoutApp
//
//  Created by Justin on 2020/12/13.
//


// format: {"success": true, "data": {"id": 1, "date": "2/21/20", "notes": "Monday Workout", "exercises": []}} // exercise: {"success": true, "data": {"id": 1, "number": null, "reps": null, "weight": "125 lbs"}}
// {"success": true, "data": [{"id": 1, "username": "Bench", "password": null, "age": null, "weight": null, "sex": null,



struct WorkoutsDataResponse: Codable {
    /* Instructions: Take a look at the JSON response we get from our HTTP Requests.
     * Model your RestaurantsDataResponse object after the JSON response.
     */
    var workouts: [Workout]
}

struct Workout: Codable {
    // format: {"success": true, "data": {"id": 1, "date": "2/21/20", "name": "Workout 1", notes": "Monday Workout", "exercises": []}}

     
    
}

