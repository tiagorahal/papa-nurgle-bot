#!/usr/bin/env python3
# tools/generate_phrases.py
"""
Gerador de frases temáticas de Nurgle
Cria milhares de variações únicas de saudações
"""

import json
import random
from itertools import combinations
from typing import List, Dict

class NurglePhraseGenerator:
    def __init__(self):
        # Palavras e temas principais
        self.subjects = [
            "decadência", "podridão", "pestilência", "imundície", "doença", "praga",
            "bênçãos", "jardim", "lama", "pus", "solo pútrido", "ciclo eterno",
            "morte", "renascimento", "corrupção", "sofrimento", "renovação",
            "Pai Nurgle", "Senhor da Praga", "Avô Nurgle", "Grande Imundo",
            "entropia", "feridas", "chagas", "fungos", "esporos", "necrose",
            "gangrena", "putrefação", "decomposição", "miasma", "contágio",
            "infecção", "bile", "icor", "vísceras", "tumores", "pústulas",
            "lepra", "cólera", "ferrugem", "mofo", "bolor", "parasitas",
            "vermes", "larvas", "moscas", "pragas ancestrais", "dádivas pútridas"
        ]
        
        # Adjetivos para enriquecer
        self.adjectives = [
            "sagrada", "divina", "gloriosa", "eterna", "infinita", "abençoada",
            "pútrida", "fétida", "necrosada", "gangrenada", "pestilenta",
            "verdejante", "borbulhante", "supurante", "viscosa", "pegajosa",
            "amorosa", "paternal", "generosa", "jubilosa", "risonha"
        ]
        
        # Templates básicos
        self.basic_templates = [
            "Que {adj} {subj} seja seu eterno companheiro.",
            "Regozije-se na {adj} {subj} de Nurgle.",
            "Na {adj} {subj}, encontre consolo.",
            "Deixe a {adj} {subj} guiar seu caminho.",
            "Banhe-se na {adj} {subj} concedida por Nurgle.",
            "Que a {adj} {subj} lhe traga alegria eterna.",
            "Na {adj} {subj}, encontre sua renovação.",
            "Deleite-se na {adj} {subj} do Pai da Praga.",
            "Deixe a {adj} {subj} consumir seus medos.",
            "Que a {adj} {subj} floresça dentro de você.",
            "Abrace a {adj} {subj} com gratidão infinita.",
            "A {adj} {subj} é a maior dádiva de Papa Nurgle.",
            "Através da {adj} {subj}, alcance a iluminação.",
            "Permita que a {adj} {subj} transforme sua existência.",
            "Na {adj} {subj}, descubra o verdadeiro significado.",
            "Celebre a {adj} {subj} com seus irmãos.",
            "A {adj} {subj} te aguarda no jardim eterno.",
            "Sinta a {adj} {subj} pulsar em suas veias.",
            "Respire a {adj} {subj} e renasça.",
            "Dance na {adj} {subj} de Nurgle."
        ]
        
        # Templates complexos
        self.complex_templates = [
            "Quando a {adj1} {subj1} encontra a {adj2} {subj2}, nasce a verdadeira bênção.",
            "Entre a {adj1} {subj1} e a {adj2} {subj2}, Papa Nurgle sorri.",
            "A {adj1} {subj1} abraça a {adj2} {subj2} no jardim eterno.",
            "Onde a {adj1} {subj1} prospera, a {adj2} {subj2} floresce.",
            "A união da {adj1} {subj1} com a {adj2} {subj2} é o amor de Nurgle.",
            "Na convergência da {adj1} {subj1} e {adj2} {subj2}, encontre a verdade.",
            "Testemunhe como a {adj1} {subj1} alimenta a {adj2} {subj2}.",
            "A {adj1} {subj1} e a {adj2} {subj2} dançam em harmonia pútrida.",
            "Contemple a {adj1} {subj1} gerando a {adj2} {subj2}.",
            "A {adj1} {subj1} sussurra segredos para a {adj2} {subj2}."
        ]
        
        # Templates épicos (para ocasiões especiais)
        self.epic_templates = [
            "Pelos sete círculos de pestilência, que a {adj} {subj} seja sua salvação eterna!",
            "Em nome do Trono de Crânios Apodrecidos, a {adj} {subj} te marca como escolhido!",
            "Do Caldeirão Primordial emerge a {adj} {subj} para abençoar sua jornada!",
            "As Sete Pragas Sagradas convergem na {adj} {subj} que agora é sua!",
            "O Grande Jardim ressoa com a {adj} {subj} de sua devoção!",
            "Mortarion sussurra: 'A {adj} {subj} é seu destino!'",
            "Typhus proclama: 'A {adj} {subj} te escolheu!'",
            "Do Warp profundo, a {adj} {subj} emerge para te abraçar!",
            "O próprio Papa Nurgle decreta: 'A {adj} {subj} é tua!'",
            "Nas profundezas do Eye of Terror, a {adj} {subj} grita seu nome!"
        ]
        
        # Prefixos e sufixos opcionais
        self.prefixes = [
            "", "Ah! ", "Oh, devoto! ", "Filho da pestilência, ",
            "Querido infectado, ", "Abençoado seja! ", "Irmão na podridão, ",
            "Campeão da entropia, ", "Arauto da decadência, ", "Escolhido, ",
            "Amado de Nurgle, ", "Portador da praga, ", "Servo fiel, "
        ]
        
        self.suffixes = [
            "", " Glória a Nurgle!", " Sete bênçãos sobre você!",
            " Papa Nurgle te ama!", " Espalhe a alegria da decadência!",
            " Que a entropia te guie!", " Apodreça em paz!",
            " Louvado seja o Pai!", " Que as pragas te protejam!",
            " A podridão é amor!", " Eternamente infectado!",
            " Nurgle vive em você!", " Propague a bênção!"
        ]

    def generate_basic(self) -> str:
        """Gera uma frase básica"""
        template = random.choice(self.basic_templates)
        adj = random.choice(self.adjectives)
        subj = random.choice(self.subjects)
        
        # Ajustar concordância de gênero (simplificado)
        if subj.endswith('o') or subj in ['jardim', 'Pai Nurgle', 'Senhor da Praga']:
            adj = adj.replace('a', 'o') if adj.endswith('a') else adj
        
        return template.format(adj=adj, subj=subj)

    def generate_complex(self) -> str:
        """Gera uma frase complexa com dois elementos"""
        template = random.choice(self.complex_templates)
        adj1 = random.choice(self.adjectives)
        adj2 = random.choice(self.adjectives)
        subj1 = random.choice(self.subjects)
        subj2 = random.choice([s for s in self.subjects if s != subj1])
        
        # Ajustar concordância (simplificado)
        if subj1.endswith('o') or subj1 in ['jardim', 'Pai Nurgle']:
            adj1 = adj1.replace('a', 'o') if adj1.endswith('a') else adj1
        if subj2.endswith('o') or subj2 in ['jardim', 'Pai Nurgle']:
            adj2 = adj2.replace('a', 'o') if adj2.endswith('a') else adj2
            
        return template.format(adj1=adj1, subj1=subj1, adj2=adj2, subj2=subj2)

    def generate_epic(self) -> str:
        """Gera uma frase épica"""
        template = random.choice(self.epic_templates)
        adj = random.choice(self.adjectives)
        subj = random.choice(self.subjects)
        
        if subj.endswith('o') or subj in ['jardim', 'Pai Nurgle']:
            adj = adj.replace('a', 'o') if adj.endswith('a') else adj
            
        return template.format(adj=adj, subj=subj)

    def generate_with_decorations(self, phrase_type="random") -> str:
        """Gera uma frase com prefixos e sufixos opcionais"""
        prefix = random.choice(self.prefixes) if random.random() > 0.5 else ""
        suffix = random.choice(self.suffixes) if random.random() > 0.5 else ""
        
        if phrase_type == "epic" or (phrase_type == "random" and random.random() < 0.1):
            phrase = self.generate_epic()
        elif phrase_type == "complex" or (phrase_type == "random" and random.random() < 0.3):
            phrase = self.generate_complex()
        else:
            phrase = self.generate_basic()
        
        # Capitalizar primeira letra
        phrase = phrase[0].upper() + phrase[1:] if phrase else phrase
        
        return f"{prefix}{phrase}{suffix}"

    def generate_batch(self, count: int = 1000, include_originals: bool = True) -> List[Dict[str, str]]:
        """Gera um lote de frases únicas"""
        phrases = []
        seen = set()
        
        # Incluir frases originais se solicitado
        if include_originals:
            originals = [
                "Que as bênçãos de Nurgle chovam sobre você.",
                "Regozije-se no abraço da decadência.",
                "Que a doce podridão de Nurgle esteja com você.",
                "Na imundície e pestilência, encontre consolo.",
                "Banhe-se na decadência amorosa de Nurgle.",
                "Que suas pragas sejam abundantes.",
                "Abrace o glorioso ciclo de vida e morte.",
                "Na pestilência, encontre renovação.",
