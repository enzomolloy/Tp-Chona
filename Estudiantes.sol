// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Estudiante
{
    //Creo las variables, el mapping y el array
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => uint) private notas_materias;
    string[] private prom;

    //Creo un constructor con las variables de arriba
    constructor(string memory nombre_, string memory apellido_, string memory curso_)
    {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }
 
    //Devuelve el apellido del estudiante como string
    function apellido() public view returns(string memory)
    {
        return _apellido;
    }

    //Devuelve el nombre y el apellido del estudiante como string
    function nombre_completo() public view returns(string memory)
    {
        return string(abi.encodePacked(_nombre, " " , _apellido)); //Forma "optimizada" de juntar dos strings
    }

    //Devuelve el curso del alumno como string.
    function curso() public view returns(string memory)
    {
        return _curso;
    }

    //Esta función le permite al docente ponerle una nota entre 1 y 100 al alumno 
    function set_nota_materia(uint nota, string memory materia) public
    {
        //Esto es lo que le permite solo al docente poner la nota
        //La coma seria un else que le saltaria al estudiante si la tratara de cambiar
        require(_docente == msg.sender , "No podes cambiar tu nota"); 

        //Esto deja que la nota solo sea entre un 100 y un 1                                                      
        require(nota <=100 && nota >= 1, "La nota tiene que ser entre 1 y 100");

        //Esto asigna el valor notas_materias a nota donde la key es la materia.
        notas_materias[materia] = nota;
        
        //Lo manda como prom
        prom.push(materia); 
    }

    //Devuelve la nota dependiendo de la materia
    function nota_materia(string memory materia) public view returns(uint)
    {
        return notas_materias[materia];
    }

    //Esta función sirve para saber si el alumno aprobo o no.
    function aprobo(string memory materia) public view returns(bool)
    {
        //Aca le dice que si la nota de la materia es mayor a 60, es decir un 6+ 
        //que le devuleva true ya que es una estructura booleana, si no lo es desaprobo.
        require (notas_materias[materia] >= 60, "desaprobaste"); 
        return true;
        
    }

    //Esta función va a calcular el promedio del alumno  
    function promedio() public view returns(uint)
    {
        uint _notaPromedio = 0; //Declaramos una variable de valor entero, int. 

        //Este for se repite una cantidad de veces igual a la cantidad de materias en prom
        //Luego agarra la nota correspondiente a cada materia y la suma a _notaPromedio
        for(uint i = 0; i < prom.length; i++)
        {
            _notaPromedio += notas_materias[prom[i]];
        }

        //Devolvemos las notas total dividivas la cantidad de materias totales  
        return _notaPromedio / prom.length; 
    }


}

