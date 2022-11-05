package etms.web.service;

import etms.web.mapper.LessonMapper;
import etms.web.mapper.LessonParticipantsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LessonService
{

    @Autowired
    private LessonMapper lessonMapper;
    @Autowired
    private LessonParticipantsMapper lessonParticipantsMapper;
}
