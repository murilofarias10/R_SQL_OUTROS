/* antes o arquivo era estatico
@Component({
        selector: 'app-course-list',
    template: '<h2> Course List </h2>'
})
agora mudamos para ler um arquivo html
*/

import {Component, OnInit } from "@angular/core";
import {Course} from './course';
import { CourseService } from "./course.service";

@Component({
        selector: 'app-course-list',
    templateUrl : './course-list.component.html'
})

/*
export class CourseListComponent implements OnInit {
        */

export class CourseListComponent implements OnInit {
    courses: Course[] = []; 

    constructor(private courseService: CourseService){ }

    ngOnInit(): void {
    this.courses = this.courseService.retrieveAll();

}
/* ANTERIOR
    ngOnInit(): void {
    this.courses = [
            {
                id: 1,
                name: 'Murilo',
                imageUrl: '/assets/images/forms.png',
                price: 99.99,
                code: 'MUR-1992',
                duration: 120,
                rating: 2.5,
                releaseDate: 'November, 10, 2021'
            },
            {
                id: 2,
                name: 'Thamie',
                imageUrl: '/assets/images/http.png',
                price: 49.99,
                code: 'TMY-1998',
                duration: 80,
                rating: 5.0,
                releaseDate: 'November, 10, 2021'
             }
                    ]
}
*/
      }