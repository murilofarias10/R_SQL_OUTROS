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

    filtercourses: Course[]=[];
filtercourses2: Course[]=[];

    _courses: Course[] = []; 
_courses2: Course[] = []; 

    _filterby!: string;
_filterby2!: string;
    constructor(private courseService: CourseService){ }

    ngOnInit(): void {
    this._courses = this.courseService.retrieveAll();
this._courses2 = this.courseService.retrieveAll();

    this.filtercourses = this._courses;
 this.filtercourses2 = this._courses2;
}

    set filter(value: string){
    this._filterby = value;
    this.filtercourses = this._courses.filter((course: Course) => course.name.toLocaleLowerCase().indexOf(this._filterby.toLocaleLowerCase()) > -1);
}

set filter2(value: string){
    this._filterby2 = value;
    this.filtercourses = this._courses2.filter((course: Course) => course.price.toLocaleString().indexOf(this._filterby2.toLocaleString()) > -1);
}
    get filter() {
    return this._filterby;
}

 get filter2() {
    return this._filterby2;
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