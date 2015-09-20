class EnumTest{//enumerations:
	//enums are simple classes that can be used like this:
	enum CarsType{
		case Tractor
		case Sports
		case Sedan
		//or case Tractor, Sports,Sedan
	}
	
	var johnLikes:CarType
	johnLikes = CarType.Sedan
	johnLikes = .Sedan
	
	switch johnLikes{
		case .Sedan
			printin("he likes sedan")
		case .Sports
			printin("he likes sport cars")
		case .Tractor
			printin("he likes tractors")
		default
			break;
	}
}