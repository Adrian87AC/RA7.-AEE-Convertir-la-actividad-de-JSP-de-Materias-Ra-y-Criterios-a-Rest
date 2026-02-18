package com.tuempresa.gestionra.service;

import com.tuempresa.gestionra.model.Materia;
import com.tuempresa.gestionra.repository.MateriaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MateriaService {

    @Autowired
    private MateriaRepository materiaRepository;

    public List<Materia> findAll() {
        return materiaRepository.findAll();
    }

    public Optional<Materia> findById(Integer id) {
        return materiaRepository.findById(id);
    }

    public Materia save(Materia materia) {
        return materiaRepository.save(materia);
    }

    public void deleteById(Integer id) {
        materiaRepository.deleteById(id);
    }
}
