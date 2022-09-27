import UIKit
import Foundation

class ChosenRecipeModel {
    var imagemReceita : UIImage
    var nomeDaReceita  : String
    var tempoDePreparo  : String
    var dificuldade : String
    var idadeRecomendada: Int
    var ingredientes : [String]
    var etapas : [String]
    
    
    init(imagemReceita : UIImage,nomeDaReceita : String,tempoDePreparo : String,dificuldade : String,idadeRecomendada : Int,ingredientes : [String],etapas : [String]){
        self.imagemReceita = imagemReceita
        self.nomeDaReceita = nomeDaReceita
        self.tempoDePreparo = tempoDePreparo
        self.dificuldade = dificuldade
        self.idadeRecomendada = idadeRecomendada
        self.ingredientes = ingredientes
        self.etapas = etapas
    }
    init() {
        self.imagemReceita = UIImage(named: "imagePlaceholder")!
        self.nomeDaReceita = ""
        self.tempoDePreparo = ""
        self.dificuldade = ""
        self.idadeRecomendada = 0
        self.ingredientes = []
        self.etapas = []
    }
    
}

func getChoosenRecipe() -> [ChosenRecipeModel]{
    var ChosenRecipe : [ChosenRecipeModel] = []
    ChosenRecipe = [
        ChosenRecipeModel(imagemReceita: UIImage(named: "paodequeijo.1")!, nomeDaReceita: "Pão de Queijo", tempoDePreparo: "30 min", dificuldade: "Fácil", idadeRecomendada: 4, ingredientes: ["400g de polvilho doce ou de sua preferência","400g de queijo parmesão ralado","2 caixas de creme de leite (400g)","Para untar: manteiga e trigo, spray untador, papel manteiga ou óleo."], etapas: ["Preparo da massa","Preparo das formas","Finalizar preparo"]),
        ChosenRecipeModel(imagemReceita: UIImage(named: "pipoca")!, nomeDaReceita: "Pipoca", tempoDePreparo: "4 min", dificuldade: "Fácil", idadeRecomendada: 3, ingredientes: ["4 colheres (sopa) de milho para pipoca","4 colheres (sopa) de água","1 colher (chá) de sal","Plástico Filme"], etapas: ["Juntar","Cobrir","Microondas"]),
        ChosenRecipeModel(imagemReceita: UIImage(named: "pipoca")!, nomeDaReceita: "Panqueca Colorida", tempoDePreparo: "15 min", dificuldade: "Fácil", idadeRecomendada: 6, ingredientes: ["1 xícara de leite","2 ovos","1 xícara de farinha","1 colher de sopa de óleo", "1 colher de café rasa de sal", "2 xícaras de cenoura ralada", "1 ½ xícara de beterraba ralada"], etapas: ["Fazer a Massa","Fritar","Finalizar"])]
    return ChosenRecipe
}
