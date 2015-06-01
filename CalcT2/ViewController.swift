//
//  ViewController.swift
//  CalcT2
//
//  Created by Efren Alejandro Barroso Llanes on 5/30/15.
//  Copyright (c) 2015 Efren Alejandro Barroso Llanes. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet var pantalla: UILabel!
    var estaUsuarioTecleandoNum = false
    var error = false
    
    var pilaOperandos = Array<Double>()
    var resultado : Double
    {
        get
        {
            return NSNumberFormatter().numberFromString(pantalla.text!)!.doubleValue
        }
        set
        {
            if(error)
            {
                pantalla.text = "ERROR"
            }
            else
            {
                pantalla.text = "\(newValue)"
            }
            estaUsuarioTecleandoNum = false
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func procesarNum(sender: UIButton)
    {
        if(estaUsuarioTecleandoNum)
        {
            pantalla.text = pantalla.text! + sender.currentTitle!
        }
        else
        {
            pantalla.text = sender.currentTitle
            estaUsuarioTecleandoNum = true
        }
        
    }
    @IBAction func terminarCapturaNum()
    {
        if(error)
        {
            inicializar()
            error=false
        }
        else
        {
            estaUsuarioTecleandoNum = false
            pilaOperandos.append(resultado)
        }
    }
    @IBAction func inicializar()
    {
        if(pilaOperandos.count>0)
        {
            pilaOperandos.removeAll(keepCapacity: false)
            
        }
        resultado = 0
        estaUsuarioTecleandoNum = false
        pantalla.text = "0.00"
    }
    @IBAction func calcular(sender: UIButton)
    {
        let operador = sender.currentTitle!
        
        
        if(estaUsuarioTecleandoNum)
        {
            terminarCapturaNum()
        }
        
        if(error)
        {
            inicializar()
        }
        error = false
        
        switch operador
        {
            case "➕":
                ejecutarOperacion{$0 + $1}
                break
            case "➖":
                ejecutarOperacion{$1 - $0}
                break
            case "✖️":
                ejecutarOperacion{$0 * $1}
                break
        case "➗":
                //ejecutarOperacion{$1 / $0}
            dividir()
            break
        case "√":
            ejecutarOperacionUnaria{sqrt($0)}
            break
        default:
            break
                
        }
    }
    
    func ejecutarOperacion ( operation: (Double, Double) -> Double )
    {
        if(pilaOperandos.count>=2)
        {
            resultado = operation (pilaOperandos.removeLast(),pilaOperandos.removeLast())
            terminarCapturaNum()
        }
    }
    
    func ejecutarOperacionUnaria ( operation: Double -> Double )
    {
        if(pilaOperandos.count>=1)
        {
            resultado = operation (pilaOperandos.removeLast())
            terminarCapturaNum()
        }
    }
    func dividir ()
    {
        var res : Double
        var op1 : Double
        var op2 : Double
        if(pilaOperandos.count>=2)
        {
            op2 = pilaOperandos.removeLast()
            op1 = pilaOperandos.removeLast()
            res = 0
            if(op2 > 0)
            {
                res = op1/op2
            }
            else
            {
                error = true
            }
            resultado = res
        }
    }
}