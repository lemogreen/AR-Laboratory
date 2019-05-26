//
//  WilberforcePendulumLaboratory.swift
//  AR Laboratory
//
//  Created by Anton Kovalenko on 23/05/2019.
//  Copyright © 2019 Anton Kovalenko. All rights reserved.
//

import Foundation

let name_WilberforcePendulum = "Маятник Уилберфорса"

let description_WilberforcePendulum = "Маятник Уилберфорса состоит из пружины 1 с подвешенным на ней металлическим цилиндром 2, снабженным цилиндрическим прутком (спицей) 3 с перемещаемыми по ней дисками 4 (рис.5.14). Пружина обладает продольной (k1) и крутильной (k2) жесткостью, поэтому маятник может совершать как продольные, так и крутильные колебания. Верхний конец пружины закреплен на консоле 5. Рассмотрим колебание груза, подвешенного на пружине (рис. 5.4.1). При движении маятник может совершать как поступательное движение по вертикали вверх и вниз, так и колебательное движение вокруг своей вертикальной оси. Если груз, спокойно находящийся в равновесии, осторожно повернуть вокруг этой оси и отпустить, кроме крутильных колебаний можно наблюдать и вертикальные."

let coverImage_WilberforcePendulum = "wilberforce_pendulum_cover"

let mathematical_Wilberforcependulum = "wilberforce_mathematicalModel"

let configuration_WilberforcePendulum = NSAttributedString(string: "Жесткость - от 100 до 1000 кн")


let laboratoryModel_Wilberforcependulum = "LaboratoriesModels.scnassets/WilberforcePendulum/Wilberforce.scn"

let wilberforcePendulum = Laboratory(nameOfTheLaboratory: name_WilberforcePendulum, descriptionOfTheLaboratory: description_WilberforcePendulum, laboratoryCoverImage: coverImage_WilberforcePendulum, mathematicalModelImage: mathematical_Wilberforcependulum, configurationOfLaboratory: configuration_WilberforcePendulum, laboratoryModel: laboratoryModel_Wilberforcependulum)



