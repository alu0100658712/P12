require "matrices_p9.rb"

class DSLMatrices
	attr_accessor :operandos, :op, :tipos, :resultado

	def initialize (operador, &bloque)
		@operandos = []
		@op = operador
		@tipos = []
		@resultado
		
		instance_eval &bloque
	end

	def to_s
		"#{@resultado}"
	end

	def operando (matriz)
		t = @tipos.pop
		if (t == "densa")
			m = MatrizDensa.new(matriz.size**0.5, matriz.size**0.5, matriz)
		else
			if(t == "dispersa")
				m = MatrizDispersa.new(matriz[0],matriz[0],matriz[1],matriz[2],matriz[3])
			end
		end
		@operandos << m

		if(@operandos.size == 2)
			operador
		end
	
		if(@op == "max" or @op == "min")
			operador
		end
	end
	
	def tipo (cosa)
		@tipos << cosa
	end

	
	def operador
		if (@operandos.size == 2)
			if (@operandos[0].instance_of?MatrizDispersa and @operandos[1].instance_of?MatrizDispersa)
				@resultado=MatrizDispersa.new(@operandos[0].fil, @operandos[0].col, [],[],[])
			else
				@resultado=MatrizDensa.new(@operandos[0].fil, @operandos[0].col, nil)
			end
		end
		
		if (@op == "suma")
			@resultado.igual(@operandos[0] + @operandos[1])
		end
		
		if (@op == "resta")
			@resultado.igual(@operandos[0] - @operandos[1])
		end

		if (@op == "max")
			@resultado = (@operandos[0]).max
		end

		if (@op == "min")
			@resultado = (@operandos[0]).min
		end
	end
	

end


pruebaSuma = DSLMatrices.new("suma") do
	tipo "densa"
	operando [1,2,3,4]
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

pruebaSumaDen2 = DSLMatrices.new("suma") do
	tipo "densa"
	operando [1,2,3,4]
	tipo "densa"
	operando [1,2,3,4]
end

pruebaResta = DSLMatrices.new("resta") do
	tipo "densa"
	operando [1,2,3,4]
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

pruebaRestaDisp2 = DSLMatrices.new("resta") do
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

pruebaMinDensa = DSLMatrices.new("min") do
	tipo "densa"
	operando [1,2,3,4]
end

pruebaMinDispersa = DSLMatrices.new("min") do
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

pruebaMaxDensa = DSLMatrices.new("max") do
	tipo "densa"
	operando [1,2,3,4]
end

pruebaMaxDispersa = DSLMatrices.new("max") do
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

puts pruebaSuma
puts pruebaResta
puts pruebaSumaDen2
puts pruebaRestaDisp2
puts pruebaMinDensa
puts pruebaMinDispersa
puts pruebaMaxDensa
puts pruebaMaxDispersa








