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
                name: 'BRASIL',
                imageUrl: '/assets/images/brasil.png',
                price: 9, /* medal ouro */
                code: 2, /* medal prata */
                rating: 5,     
                bronze: 10,  /* medal bronze */  
                totalmedal: 10, 
                opcoes: 'teste'
            },
 {
                id: 4,
                name: 'JAPAO',
                imageUrl: '/assets/images/japao.png',
                price: 88,
                code: 8,       
                rating: 5.0,   
                bronze: 0,  /* medal bronze */         
                totalmedal: 14,
                opcoes: 'teste'
             },
{
                id: 4,
                name: 'EUA',
                imageUrl: '/assets/images/eua.png',
                price: 88,
                code: 16,         
                rating: 5.0,       
                bronze: 2,  /* medal bronze */     
                totalmedal: 14,
                opcoes: 'teste'
             },
            {
                id: 2,
                name: 'ALEMANHA',
                imageUrl: '/assets/images/alemanha.png',
                price: 8,
                code: 2,
                rating: 4.5,      
                bronze: 10,  /* medal bronze */      
                totalmedal: 20,
                opcoes: 'teste'
             },

               
                {
                id: 4,
                name: 'CANADA',
                imageUrl: '/assets/images/canada.png',
                price: 88,
                code: 16,           
                rating: 5.0,     
                bronze: 6,  /* medal bronze */       
                totalmedal: 14,
                opcoes: 'teste'
             },
 
 
 {
                id: 4,
                name: 'FRANÇA',
                imageUrl: '/assets/images/franca.png',
                price: 88,
                code: 1,          
                rating: 5.0,             
                totalmedal: 14,
                bronze: 1,  /* medal bronze */  
                opcoes: 'teste'
             },
 {
                id: 4,
                name: 'KOSOVO',
                imageUrl: '/assets/images/kosovo.png',
                price: 88,
                code: 9,      
                rating: 5.0,    
                bronze: 0,  /* medal bronze */   
                totalmedal: 14,
                opcoes: 'teste'
             },
 
 {
                id: 4,
                name: 'ITALIA',
                imageUrl: '/assets/images/italia.png',
                price: 88,
                code: 17,         
                rating: 5.0,    
                bronze: 0,  /* medal bronze */  
                totalmedal: 14,
                opcoes: 'teste'
             },
{
                id: 4,
                name: 'GBT',
                imageUrl: '/assets/images/granbetania.png',
                price: 88,
                code: 13,      
                rating: 5.0,
                bronze: 0,  /* medal bronze */  
                totalmedal: 14,
                opcoes: 'teste'
             },


 {
                id: 4,
                name: 'KOREIA',
                imageUrl: '/assets/images/koreia.png',
                price: 88,
                code: 6,         
                rating: 5.0,  
                bronze: 0,  /* medal bronze */            
                totalmedal: 14,
                opcoes: 'teste'
             },
{
                id: 4,
                name: 'CHINA',
                imageUrl: '/assets/images/china.png',
                price: 88,
                code: 12,           
                rating: 5.0,     
                bronze: 5,  /* medal bronze */      
                totalmedal: 14,
                opcoes: 'teste'
             },

 {
                id: 4,
                name: 'RUSSIA',
                imageUrl: '/assets/images/russia.png',
                price: 88,
                code: 4,        
                rating: 5.0,   
                bronze: 0,  /* medal bronze */        
                totalmedal: 14,
                opcoes: 'teste'
             },
 {
                id: 3,
                name: 'AUSTRALIA',
                imageUrl: '/assets/images/australia.png',
                price: 56,
                code: 14,             
                rating: 5.0,    
                bronze: 6,       
                totalmedal: 14,
                opcoes: 'teste'
             },
 

]

