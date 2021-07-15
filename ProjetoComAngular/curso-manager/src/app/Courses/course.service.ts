import { Injectable } from "@angular/core";
import { Course } from "./course";


@Injectable({
    providedIn: 'root'

})
export class CourseService {

    retrieveAll(): Course[]{
    return COURSES;
}

}

var COURSES: Course[] = [

{
                id: 1,
                name: 'aaaaa',
                imageUrl: '/assets/images/forms.png',
                price: 99.99,
                code: 'MUR-1992',
                duration: 120,
                rating: 2.5,
                releaseDate: 'November, 10, 2021'
            },
            {
                id: 2,
                name: 'bbbbb',
                imageUrl: '/assets/images/http.png',
                price: 49.99,
                code: 'TMY-1998',
                duration: 80,
                rating: 5.0,
                releaseDate: 'November, 10, 2021'
             },

{
                id: 3,
                name: 'ccccc',
                imageUrl: '/assets/images/http.png',
                price: 49.99,
                code: 'TMY-1998',
                duration: 80,
                rating: 5.0,
                releaseDate: 'November, 10, 2021'
             }




]