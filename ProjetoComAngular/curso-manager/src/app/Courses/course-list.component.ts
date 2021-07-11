/* antes o arquivo era estatico
@Component({
        selector: 'app-course-list',
    template: '<h2> Course List </h2>'
})
agora mudamos para ler um arquivo html
*/

import {Component, OnInit } from "@angular/core";
import {Course} from './course';

@Component({
        selector: 'app-course-list',
    templateUrl : './course-list.component.html'
})

/*
export class CourseListComponent implements OnInit {
        */

export class CourseListComponent implements OnInit {
    courses: Course[] = []; 
    ngOnInit(): void {
    this.courses = [
            {
                id: 1,
                name: 'Murilo',
                imageUrl: '',
                price: 99.99,
                code: 'XPS-8799',
                duration: 120,
                rating: 4.5,
                releaseDate: 'November, 10, 2021'
            },
            {
                id: 2,
                name: 'Thamie',
                imageUrl: '',
                price: 49.99,
                code: 'LKL-8799',
                duration: 80,
                rating: 5.4,
                releaseDate: 'November, 10, 2021'
             }
                    ]
}
      }