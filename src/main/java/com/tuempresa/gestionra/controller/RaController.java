package com.tuempresa.gestionra.controller;

import com.tuempresa.gestionra.model.Materia;
import com.tuempresa.gestionra.model.Ra;
import com.tuempresa.gestionra.service.MateriaService;
import com.tuempresa.gestionra.service.RaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/ras")
@CrossOrigin(origins = "*")
public class RaController {

    @Autowired
    private RaService raService;

    @Autowired
    private MateriaService materiaService;

    @GetMapping
    public List<Ra> getAllRas() {
        return raService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Ra> getRaById(@PathVariable Integer id) {
        return raService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/materia/{materiaId}")
    public List<Ra> getRasByMateria(@PathVariable Integer materiaId) {
        return raService.findByMateriaId(materiaId);
    }

    @PostMapping
    public ResponseEntity<Ra> createRa(@RequestBody Map<String, Object> payload) {
        // Expecting "materiaId" in the payload along with Ra fields
        if (!payload.containsKey("materiaId")) {
            return ResponseEntity.badRequest().build();
        }

        Integer materiaId = (Integer) payload.get("materiaId");
        return materiaService.findById(materiaId)
                .map(materia -> {
                    Ra ra = new Ra();
                    ra.setCodigo((String) payload.get("codigo"));
                    ra.setDescripcion((String) payload.get("descripcion"));
                    ra.setMateria(materia);
                    return ResponseEntity.ok(raService.save(ra));
                })
                .orElse(ResponseEntity.badRequest().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Ra> updateRa(@PathVariable Integer id, @RequestBody Map<String, Object> payload) {
        return raService.findById(id)
                .map(ra -> {
                    if (payload.containsKey("codigo")) ra.setCodigo((String) payload.get("codigo"));
                    if (payload.containsKey("descripcion")) ra.setDescripcion((String) payload.get("descripcion"));
                    if (payload.containsKey("materiaId")) {
                        Integer materiaId = (Integer) payload.get("materiaId");
                        Materia materia = materiaService.findById(materiaId).orElse(null);
                        if (materia != null) {
                            ra.setMateria(materia);
                        }
                    }
                    return ResponseEntity.ok(raService.save(ra));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRa(@PathVariable Integer id) {
        if (raService.findById(id).isPresent()) {
            raService.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
