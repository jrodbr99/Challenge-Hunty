-- View of the complete information
SELECT cdf.candidates_id, qdf.question_id, response, score, discarded, conversation_end, total_conversation 
FROM hunty.responses_df
JOIN hunty.question_df as qdf on qdf.question_id = hunty.responses_df.question_id
JOIN hunty.candidatedf as cdf on cdf.candidates_id = hunty.responses_df.candidates_id;

-- See how many candidates completed all 6 questions
SELECT (COUNT(*) * 100 / (SELECT COUNT(*) FROM hunty.candidatedf)) AS percentage
FROM (
    SELECT candidates_id
    FROM hunty.responses_df
    WHERE response = 'Active Response'
    GROUP BY candidates_id
    HAVING COUNT(*) = 6
) AS candidates_with_six_active_responses;

-- what percentage of all questions all candidates responded
SELECT candidates_id, 
    COUNT(*) AS total_responses_count,
    SUM(CASE WHEN response = 'Active Response' THEN 1 ELSE 0 END) AS active_responses_count,
    (SUM(CASE WHEN response = 'Active Response' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS active_responses_percentage
FROM hunty.responses_df
GROUP BY candidates_id;

-- compare questions asked and questions solved
SELECT candidates_id,  qdf.question_id, question_type, response
FROM hunty.responses_df
JOIN hunty.question_df as qdf on qdf.question_id = hunty.responses_df.question_id;

-- Comparison between quenstions answered and questions asked
-- * Times a question has been answered
SELECT hunty.responses_df.question_id, question_type,
    COUNT(*) AS active_responses_count
FROM hunty.responses_df
JOIN hunty.question_df ON responses_df.question_id = question_df.question_id
WHERE response = 'Active Response'
GROUP BY question_id, question_type;

-- Total questions answered versus the score obtained by the candidate
SELECT cdf.candidates_id,
    COUNT(CASE WHEN response = 'Active Response' THEN 1 END) AS active_responses_count,
    AVG(score) AS average_score
FROM hunty.responses_df
JOIN hunty.question_df AS qdf ON qdf.question_id = hunty.responses_df.question_id
JOIN hunty.candidatedf AS cdf ON cdf.candidates_id = hunty.responses_df.candidates_id
GROUP BY cdf.candidates_id;

-- type and id of the questions unanswered vs the score obtained by candidate
SELECT 
    cdf.candidates_id,
    COUNT(CASE WHEN response != 'Active Response' THEN 1 END) AS unanswered_count,
    GROUP_CONCAT(DISTINCT qdf.question_type) AS unanswered_question_types,
    GROUP_CONCAT(DISTINCT hunty.responses_df.question_id) AS unanswered_question_ids,
    SUM(score) AS total_score
FROM hunty.responses_df
JOIN hunty.question_df AS qdf ON qdf.question_id = hunty.responses_df.question_id
JOIN hunty.candidatedf AS cdf ON cdf.candidates_id = hunty.responses_df.candidates_id
WHERE response != 'Active Response'
GROUP BY cdf.candidates_id;

-- How the conversation ended, total answered questions and score
SELECT hunty.responses_df.candidates_id, conversation_end,
    COUNT(CASE WHEN response = 'Active Response' THEN 1 END) AS active_responses_count,
    score
FROM hunty.responses_df
JOIN hunty.candidatedf ON responses_df.candidates_id = candidatedf.candidates_id
GROUP BY candidates_id, conversation_end, score;

