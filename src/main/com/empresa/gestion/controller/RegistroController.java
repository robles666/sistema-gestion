package com.empresa.gestion.controller;

import com.empresa.gestion.model.Registro;
import com.empresa.gestion.repository.RegistroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/registros")
public class RegistroController {

    @Autowired
    private RegistroRepository registroRepository;

    @GetMapping
    public List<Registro> getAllRegistros() {
        return registroRepository.findAll();
    }

    @PostMapping
    public Registro createRegistro(@RequestBody Registro registro) {
        return registroRepository.save(registro);
    }
}