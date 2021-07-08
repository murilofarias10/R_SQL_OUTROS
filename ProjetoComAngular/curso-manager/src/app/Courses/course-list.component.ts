/* antes o arquivo era estatico
@Component({
        selector: 'app-course-list',
    template: '<h2> Course List </h2>'
})
agora mudamos para ler um arquivo html
*/




import { Component } from "@angular/core";
@Component({
        selector: 'app-course-list',
    templateUrl : './course-list.component.html'
})

          export class CourseListComponent {
        
      }