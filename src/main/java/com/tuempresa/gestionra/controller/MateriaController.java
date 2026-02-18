package com.tuempresa.gestionra.controller;

import com.tuempresa.gestionra.model.Materia;
import com.tuempresa.gestionra.service.MateriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/materias")
@CrossOrigin(origins = "*")
public class MateriaController {

    @Autowired
    private MateriaService materiaService;

    @GetMapping
    public List<Materia> getAllMaterias() {
        return materiaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Materia> getMateriaById(@PathVariable Integer id) {
        return materiaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Materia createMateria(@RequestBody Materia materia) {
        return materiaService.save(materia);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Materia> updateMateria(@PathVariable Integer id, @RequestBody Materia materiaDetails) {
        return materiaService.findById(id)
                .map(materia -> {
                    materia.setNombre(materiaDetails.getNombre());
                    materia.setCodigo(materiaDetails.getCodigo());
                    materia.setDescripcion(materiaDetails.getDescripcion());
                    materia.setCreditos(materiaDetails.getCreditos());
                    return ResponseEntity.ok(materiaService.save(materia));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMateria(@PathVariable Integer id) {
        if (materiaService.findById(id).isPresent()) {
            materiaService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
